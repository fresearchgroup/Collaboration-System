### For development installation (Virtual Environment)

Collaboration System requires Mysql Server, Python3, Pip, Nodejs, Etherpad server to be installed and running in the system.

## Clone the project repositiories from github 
	
	Collaboration System - 

	```bash
 		git clone https://github.com/fresearchgroup/Collaboration-System.git 
  	```

  	Etherpad - 

  	```bash
 		git clone https://github.com/ether/etherpad-lite
 		git clone https://github.com/fresearchgroup/Community-Content-Tools.git
  	```
  	 Copy all the contents of etherpad-lite to Community-Content-Tools/etherpad-lite

## Installation 

## Install Mysql server --

	```
		$ sudo apt-get update
		
		$ sudo apt-get install mysql-server
 
		$ sudo apt-get install libmysqlclient-dev

        $ mysql -u root -p

        Enter password
		
	mysql> create database collaboration;
        mysql> use collaboration;
        mysql> source collab.sql  (this dump database is present in 'Collaboration-System' directory)

## Install Node and Etherpad server --

 	```bash
 		curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh 
 	```
 	Run the script with bash:

 	```bash
	bash install_nvm.sh 

	source ~/.profile 

	nvm ls-remote

	nvm install 8.11.1 

	nvm use 8.11.1
	```

	After Nodejs is installed , go inside Community-Content-Tools/etherpad-lite folder which we have cloned before.

 	Inspect settings.json.template file , check whether database name matches properly with the database which we have created before in mysql, also set the following fields in the file --


		1. "requireSession" : true,
		Users must have a session to access pads. This effectively allows only group pads to be accessed.
		
		2. "editOnly" : true,
		Users may edit pads but not create new ones. Pad creation is only via the API. This applies both to group pads and regular pads.

	Run the following commands
	
		./bin/run.sh

	If everything is configured properly this will install and run the etherpad server.

## Install Collaboration System

Keep the Etherpad server running and open a new terminal. Go inside Collaboration-System directory and 


1. Install virtualenv 

 	```bash
 		sudo pip3 install virtualenv 
 	```

 	Note: If you dont have pip installed in the system, then install using following command

 		```bash
 			sudo apt-get install python3-pip
 		```

2. Create a virtual env --- 

	```bash
     	virtualenv venv -p python3 
	```

3. Activate the virtual environment -- 

     ```bash
     	source venv/bin/activate
     ```

4. Install the requirements.txt -- 

	```bash
		pip3 install -r requirements.txt
	```

5. Create a .env file from .env.example inside Collaboration-System and edit it-
	```bash
			sudo cp .env.example .env
			sudo nano .env
	```

	Check the following variables --

	DB_NAME -- Database name that you have created in mysql server.

	DB_USER -- Username of mysql server
	DB_PASSWORD -- password of mysql server

	APIKEY -- this will be the api key of etherpad server. The api key is present inside Community-Content-Tools/etherpad-lite folder.

	Copy the key from Community-Content-Tools/etherpad-lite/APIKEY.txt and paste it in APIKEY variable in .env file.

	Save the .env file and run the following commands.


8. Do all the migrations --

	```bash
		python3 manage.py migrate
	```
			
9. Runserver --

    ```bash
    	python3 manage.py runserver
    ``` 