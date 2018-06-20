[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![CodeFactor](https://www.codefactor.io/repository/github/fresearchgroup/collaboration-system/badge)](https://www.codefactor.io/repository/github/fresearchgroup/collaboration-system)
[![Build Status](https://travis-ci.org/fresearchgroup/Collaboration-System.svg?branch=master)](https://travis-ci.org/fresearchgroup/Collaboration-System)

COLLABORATION SYSTEM

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

   git clone https://github.com/fresearchgroup/Collaboration-System.git

2. The run the following commands inside the repository --

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
 
 
