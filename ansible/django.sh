
export DEBIAN_FRONTEND="noninteractive"

sudo -S <<< $1 apt-get update
sudo -S <<< $1 apt-get install -y debconf

sudo -S <<< $1 debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo -S <<< $1 debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

sudo -S <<< $1 apt-get update
sudo -S <<< $1 apt-get install -y mysql-server

echo "Creating a django database"
mysql -uroot -proot -e "CREATE DATABASE django ;"


echo "Restarting Mysql"
sudo -S <<< $1 /etc/init.d/mysql restart


echo "Downloading package for django instalation"
echo "Installing Debian/Ubuntu packages..."

sudo -S <<< $1 apt-get update
sudo -S <<< $1 apt-get --yes install nginx
sudo -S <<< $1 apt-get --yes install python3-dev libmysqlclient-dev 
sudo -S <<< $1 apt-get --yes install supervisor

sudo -S <<< $1 systemctl enable supervisor
sudo -S <<< $1 systemctl start supervisor

sudo -S <<< $1 apt-get --yes install python3-pip
sudo -S <<< $1 pip3 install virtualenv

git clone https://github.com/fresearchgroup/Collaboration-System.git
sudo -S <<< $1 mv Collaboration-System CollaborationSystem

virtualenv collab -p python3
source collab/bin/activate

pip3 install -r CollaborationSystem/requirements.txt
pip3 install gunicorn
pip3 install psycopg2

sudo -S <<< $1 touch CollaborationSystem/.env
sudo bash -c <<< $1 'cat > CollaborationSystem/.env <<\EOL
SECRET_KEY=myf0)*es+lr_3l0i5$4^)^fb&4rcf(m28zven+oxkd6!(6gr*6
DEBUG=True
DB_NAME=django
DB_USER=root
DB_PASSWORD=root
DB_HOST=localhost
DB_PORT=3306
ALLOWED_HOSTS= localhost, 10.129.132.103
GOOGLE_RECAPTCHA_SECRET_KEY=6Lfsk0MUAAAAAFdhF-dAY-iTEpWaaCFWAc1tkqjK
EMAIL_HOST=localhost
EMAIL_HOST_USER=
EMAIL_HOST_PASSWORD=
EMAIL_PORT=25
EMAIL_USE_TLS=False
DEFAULT_FROM_EMAIL=collaboratingcommunity@cse.iitb.ac.in
SOCIAL_AUTH_GOOGLE_OAUTH2_KEY=735919351499-ajre9us5dccvms36ilhrqb88ajv4ahl0.apps.googleusercontent.com
SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET=I1v-sHbsogVc0jAw9M9Xy1eM
EOL'

sudo -S <<< $1 sed -i '170 a  STATIC_ROOT = "/home/edx/static"' CollaborationSystem/CollaborationSystem/settings.py
python3 CollaborationSystem/manage.py collectstatic

touch gunicorn_start.bash

sudo bash -c <<< $1 'cat > gunicorn_start.bash <<\EOL

 #!/bin/bash

NAME="CollaborationSystem"           # Name of the application
DJANGODIR=/home/edx/CollaborationSystem # Django project directory
SOCKFILE=/home/edx/run/gunicorn.sock     # we will communicte using this unix socket
USER=edx                                # the user to run as
GROUP=edx                               # the group to run as
NUM_WORKERS=3       # how many worker processes should Gunicorn spawn
DJANGO_SETTINGS_MODULE=CollaborationSystem.settings # which settings file should Django use
DJANGO_WSGI_MODULE=CollaborationSystem.wsgi  # WSGI module name
echo "Starting $NAME as `whoami`"

# Activate the virtual environment

cd $DJANGODIR
source /home/edx/collab/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

# Create the run directory if it doesnt exist

RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)

exec gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=unix:$SOCKFILE \
  --log-level=debug \
  --log-file=-
EOL'

sudo -S <<< $1 chmod u+x gunicorn_start.bash
mkdir run logs
touch logs/gunicorn.log
sudo -S <<< $1 touch /etc/supervisor/conf.d/edx.conf

sudo bash -c <<< $1 'cat > /etc/supervisor/conf.d/edx.conf <<\EOL
[program:edx]
command = /home/edx/gunicorn_start.bash
user=root
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/home/edx/logs/gunicorn.log
environment=LANG=en_US.UTF-8,LC_ALL=en_US.UTF-8
EOL'

sudo -S <<< $1 systemctl restart supervisor
sudo -S <<< $1 systemctl enable supervisor

sudo bash -c <<< $1 'cat >> /etc/systemd/system/gunicorn.service <<\EOL
[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=edx
Group=www-data
WorkingDirectory=/home/edx/CollaborationSystem
ExecStart=/home/edx/collab/bin/gunicorn --access-logfile - --workers 3 --bind unix:/home/edx/run/gunicorn.sock CollaborationSystem.wsgi:application

[Install]
WantedBy=multi-user.target
EOL'

sudo -S <<< $1 systemctl start gunicorn
sudo -S <<< $1 systemctl enable gunicorn

sudo -S <<< $1 touch /etc/nginx/sites-available/edx.conf
sudo bash -c <<< $1 'cat > /etc/nginx/sites-available/edx.conf <<\EOL

server {
    listen 80;
    server_name localhost;  # here can also be the IP address of the server

    keepalive_timeout 5;
    proxy_connect_timeout 300s;
    proxy_read_timeout 300s;

    access_log /home/edx/logs/nginx-access.log;
    error_log /home/edx/logs/nginx-error.log;

    location /static/ {
       root /home/edx;
    }
   location /media/ {
       root /home/edx/CollaborationSystem;
    }
    location / {
        include proxy_params;
        proxy_pass http://unix:/home/edx/run/gunicorn.sock;
    }
}
EOL'

sudo -S <<< $1 ln -s /etc/nginx/sites-available/edx.conf /etc/nginx/sites-enabled/edx.conf
sudo ufw allow 'Nginx Full'
sudo -S <<< $1 systemctl restart nginx
sudo -S <<< $1 supervisorctl restart edx
sudo -S <<< $1 service gunicorn restart
sudo -S <<< $1 service supervisor restart


sudo -S <<< $1 cp CollaborationSystem/temp/patch_for_reversion_compare.py collab/lib/python3.5/site-packages/reversion_compare/views.py

python3 CollaborationSystem/manage.py migrate
python3 CollaborationSystem/manage.py loaddata workflow
python3 CollaborationSystem/manage.py loaddata roles
python3 CollaborationSystem/manage.py loaddata faq
