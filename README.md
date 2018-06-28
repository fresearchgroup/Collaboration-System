[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![CodeFactor](https://www.codefactor.io/repository/github/fresearchgroup/collaboration-system/badge)](https://www.codefactor.io/repository/github/fresearchgroup/collaboration-system)
[![Build Status](https://travis-ci.org/fresearchgroup/Collaboration-System.svg?branch=master)](https://travis-ci.org/fresearchgroup/Collaboration-System)

# COLLABORATION SYSTEM

        Requiremnets -

                Django - 1.11.7 LTS
                python - 3.6
                Django Rest API
                Mysql

        Django pakages installed -

                Django Rest Framework
                Widget Tweaks
                Django Reversion
                Reversion Compare
                MPTT
                Haystack
                Django Machina
                Django-cors-headers
                Django-role-permission
                Django_comments_xtd
                Django_comments
		Django_wiki


## For development installation - 

1. Install virtualenv 

 	```bash
 		sudo pip3 install virtualenv 
 	```
2. Clone the project from github
	
	```bash
 		git clone https://github.com/fresearchgroup/Collaboration-System.git 
  	```
3. Create a virtual env --- 

	```bash
     	virtualenv collab -p python3 
	```

4. Activate the virtual environment -- 

     ```bash
     	source collab/bin/activate
     ```

5. Install the requirements.txt -- 

	```bash
		pip3 install -r Collaboration-System/requirements.txt
	```

6. Install mysql server --

	```
		$ sudo apt-get update
		
		$ sudo apt-get install mysql-server
 
		$ sudo apt-get install libmysqlclient-dev

        $ mysql -u root -p

        Enter password=root
		
	mysql> create database collaboration;
        mysql> use collaboration;
        mysql> source collab.sql   
	```

7. Create a .env inside CollaborationSystem and paste the following -
	```bash
       		sudo nano .env
	```
    ```
                SECRET_KEY=myf0)*es+lr_3l0i5$4^)^fb&4rcf(m28zven+oxkd6!(6gr*6
                DEBUG=True
                DB_NAME=collaboration
                DB_USER=root
                DB_PASSWORD=root
                DB_HOST=localhost
                DB_PORT=3306
                ALLOWED_HOSTS= localhost
                GOOGLE_RECAPTCHA_SECRET_KEY=6Lfsk0MUAAAAAFdhF-dAY-iTEpWaaCFWAc1tkqjK
                EMAIL_HOST=localhost
                EMAIL_HOST_USER=
                EMAIL_HOST_PASSWORD=
                EMAIL_PORT=25
                EMAIL_USE_TLS=False
                DEFAULT_FROM_EMAIL=collaboratingcommunity@cse.iitb.ac.in
                SOCIAL_AUTH_GOOGLE_OAUTH2_KEY=735919351499-ajre9us5dccvms36ilhrqb88ajv4ahl0.apps.googleusercontent.com
                SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET=I1v-sHbsogVc0jAw9M9Xy1eM
		LOG_TYPE=TOSERVER
		LOG_PROTOCOL=http
		LOG_ADDRESS=logstash
		LOG_PORT=5000
		LOG_STORE=debug.log
		LOG_USE_PROXY=False
		URL_BASIC=http://localhost:8000/
		PAGE_SIZE=1000
		MAX_PAGE_SIZE=10000
		EVENTAPI_TOKEN_USERNAME=eventloguser
		EVENTAPI_TOKEN_PASSWORD=eventlogpass
		EVENT_API_TOKEN=
		ELASTICSEARCH_ADDRESS=
    ```

8. Do all the migrations --

	```bash
		python3 manage.py migrate
	```
			
9. Run the following to generate a new Token
			  
	```bash
		python3 manage.py generateToken --n
	```
			
10. Add/Replace the token by adding following line in .env file

	```
		EVENT_API_TOKEN=<your-token>
	``` 

11. Runserver --

    ```
    	python3 manage.py runserver
    ``` 
 
### Generating token for event logs
1. To generate a new token run
	```
		python3 manage.py generateToken --n
	```
2. To generate a renew token run
	```
		python3 manage.py generateToken --r
	```
3. To get the previous token run
	```
		python3 manage.py generateToken --g
	```

For development installation -

1. Install virtualenv

	        sudo pip3 install virtualenv

2. Clone the project from github

                git clone https://github.com/fresearchgroup/Collaboration-System.git

3. Create a virtual env ---

		 virtualenv collab -p python3

4. Activate the virtual environment --

	         source collab/bin/activate

5. Install the requirements.txt --

	         pip3 install -r Collaboration-System/requirements.txt

6. Install mysql server --

            $sudo apt-get update
            $sudo apt-get install mysql-server
            $sudo apt-get install libmysqlclient-dev
            $mysql -u root -p

            Enter password=root

	    mysql> create database collaboration;
            mysql> use collaboration;
            mysql> source collab-updated.sql 
	    mysql> exit




6.  Clone the following directory:

			git clone http://github.com/dhanushsr/etherpad-lite
			cd etherpad-lite/
			./bin/run.sh

7. Install PyEtherpadLite--

			git clone http://github.com/dhanushsr/PyEtherpadLite
			cd PyEtherpadLite
			python setup.py install
			cd ..

8. Paste the apikey from APIKEY.text from etherpad-lite folder in the .env.example file

9. Create a .env inside CollaborationSystem and paste the following -
			
			sudo cp .env.example .env

9. Do all the migrations going back to django directory--

	      python3 manage.py migrate

10. Runserver --

	      python3 manage.py runserver  


For manual installtion -- https://fresearchgroup.github.io/docs-collaboration-system/

For automated installation using nginx and gunicorn- https://github.com/abhisgithub/django-nginx-installation-script


DOCKER INSTALLATION --

 -- Install Docker and Docker-Compose from  --

	    Docker - https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository

	    Docker Compose -- https://docs.docker.com/compose/install/

1. Clone the repository --
```
   	git clone https://github.com/fresearchgroup/Collaboration-System.git
	git clone https://github.com/fresearchgroup/Community-Content-Tools.git
```
2. The run the following commands inside the repository --

Note: Community-Content-Tools repository has been referred to as the H5P directory


2. The run the following commands inside the repository --
 
	```

 		docker-compose build

 		docker-compose up db

	 	docker exec -i <container-image-name> mysql -u<username> -p<password> django < collab.sql

 		docker-compose run web python manage.py migrate

 		docker-compose run web python manage.py createsuperuser

 		docker-compose run web python manage.py loaddata workflow roles faq

 		docker-compose run web python3 manage.py generateToken --n

	```

3. Copy the generated token and add/replace the line with following in .env.docker:

	```
		EVENT_API_TOKEN=<your-token>
	```
4. Run the following command to run all containers
	```
 		docker-compose build
			
		docker-compose up

	```

### Generating token for event logs
1. To generate a new token run
	```
		sudo docker-compose run web python3 manage.py generateToken --n
	```
2. To generate a renew token run
		
	```
		sudo docker-compose run web python3 manage.py generateToken --r
	```
3. To get the previous token run

	```
	 sudo docker-compose run web python3 manage.py generateToken --g
	```

In the .env.docker of both CC and H5P,

	replace 172.17.0.1 in COLLAB_ROOT and H5P with docker0 inet address
	To find this, 
	
	$ ifconfig
	
	search for docker0 and copy inet address in place of 172.17.0.1

In the H5P directory,
```

 sudo docker build -t h5p_image .
 
```

In the Collaboration-System directory,
```

 sudo docker-compose build

 sudo docker-compose up db

 sudo docker exec -i <db-container-image-name> mysql -u<username> -p<password> django < collab-updated.sql

 sudo docker-compose up
 
 ```
 Go to `https://h5p.org/sites/default/files/official-h5p-release-20170301.h5p` and download the official h5p libraries.
 
 Go to `http://yourdockerip:8000/h5p/libraries` and upload the downloaded libraries and select proceed.
 
 

