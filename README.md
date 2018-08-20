[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![CodeFactor](https://www.codefactor.io/repository/github/fresearchgroup/collaboration-system/badge)](https://www.codefactor.io/repository/github/fresearchgroup/collaboration-system)
[![Build Status](https://travis-ci.org/fresearchgroup/Collaboration-System.svg?branch=master)](https://travis-ci.org/fresearchgroup/Collaboration-System)
[![Docs](https://img.shields.io/badge/Docs-View-blue.svg)](https://fresearchgroup.github.io/docs-collaboration-system/)

# COLLABORATION SYSTEM
The system allows individual users to form communities, create groups, participate in various activities defined in the community/group, and thus, enhance its value for the society in terms of education.

## Requirements and Django Packages
* [Python 3.6](https://python.org/)
* [Django 1.11.7](https://www.djangoproject.com/)
* [MySQL Server](https://www.mysql.com/)
* [Django REST Framework](http://www.django-rest-framework.org/)
* [django-role-permissions 2.1.0](https://djangopackages.org/packages/p/django-role-permissions/)
* [python-decouple 3.1](https://djangopackages.org/packages/p/python-decouple/)
* [PyEtherpad Lite](https://github.com/devjones/PyEtherpadLite)
* [social-auth-app-django 2.1.0](https://djangopackages.org/packages/p/social-app-django/)
* [django-comments-xtd 2.0.9](https://djangopackages.org/packages/p/django-comments-xtd/)
* [django-contrib-comments 1.8.0](https://djangopackages.org/packages/p/django-contrib-comments/)
* [django-machina 0.6.0](https://djangopackages.org/packages/p/django-machina/)
* [django-reversion 2.0.10](https://djangopackages.org/packages/p/django-reversion/)
* [django-reversion-compare 0.8.1](https://djangopackages.org/packages/p/django-reversion-compare/)
* [django-mptt 0.8.7](https://djangopackages.org/packages/p/django-mptt/)
* [django-notifications-hq 1.4.0](https://djangopackages.org/packages/p/django-notifications-hq/)
* [django-activity-stream 0.6.5](https://djangopackages.org/packages/p/django-activity-stream/)
* [django-jsonfield 1.0.1](https://djangopackages.org/packages/p/schinckel-django-jsonfield/)
* [django-widget-tweaks 1.4.1](https://djangopackages.org/packages/p/django-widget-tweaks/)
* [django-cors-headers 2.1.0](https://djangopackages.org/packages/p/django-cors-headers/)
* [Django Wiki 0.3.1](https://djangopackages.org/packages/p/django-wiki/)
* [Gunicorn](https://pypi.org/project/gunicorn/)
* [Oauthlib](https://pypi.org/project/oauthlib/)
* [Pillow](https://pypi.org/project/Pillow/)
* [Requests](https://pypi.org/project/requests/)
* [Elasticsearch](https://pypi.org/project/elasticsearch/)

## For development installation (Virtual Environment)

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
		
		NODESERVERURL=http://localhost
		NODESERVERPORT=9001
		COLLAB_ROOT=http://localhost:7000
		H5P_ROOT=http://localhost:8000
		APIKEY=ae0135343b703000e7377f8438e5f1154dcdc2ffc434268729203764cfe28b26
    ```

8. Do all the migrations --

	```bash
		python3 manage.py migrate
	```
			
9. Runserver --

    ```bash
    	python3 manage.py runserver
    ``` 
 
For manual installtion -- https://fresearchgroup.github.io/docs-collaboration-system/

For automated installation using nginx and gunicorn- https://github.com/abhisgithub/django-nginx-installation-script


## For development installation (Docker) - 

 -- Install Docker and Docker-Compose from  --

	    Docker - https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository

	    Docker Compose -- https://docs.docker.com/compose/install/

1. Clone the repository --
```
   	git clone https://github.com/fresearchgroup/Collaboration-System.git
```

2. The run the following commands inside the repository --
 
	```

 		docker-compose build

 		docker-compose up db

	 	docker exec -i <container-image-name> mysql -u<username> -p<password> django < collab.sql

 		docker-compose run web python manage.py migrate

 		docker-compose run web python manage.py createsuperuser

 		docker-compose run web python manage.py loaddata workflow roles faq

		docker-compose up
	```
### Event Logging
To set-up event logging for this system, please refer to the installation steps given in the repository link given below:
https://github.com/fresearchgroup/Collaboration-System-Event-Logs

### Interactive Content (H5P) and Real-time editing
To create and edit interactive content (H5P) and to enable real-time collaborative editing of articles, please refer to the installation steps given in the repository link given below:
https://github.com/fresearchgroup/Community-Content-Tools

### Recommendation System
This system is used to recommend articles based on his/her activity in the sytem. Please refer to the installation steps given in the repository below:
https://github.com/fresearchgroup/Community-Recommendation

### Collaborative Editing using QuillJS and ShareDB
Requirements
* [MongoDB](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)
* Node.js and npm (use [nvm](https://github.com/creationix/nvm) to install both)

Instructions to start node.js (ShareDB) server
> MongoDB should to be running on port 27017 (default port)
```
git clone https://github.com/fresearchgroup/Collaboration-System.git
git checkout cc-quilljs-sharedb
npm install
npm run build
node editor-server.js
```