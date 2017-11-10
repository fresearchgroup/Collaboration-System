
                                    COLLABORATION SYSTEM

        Requiremnets -

                Django - 1.11.6 LTS
                python - 3
                Django Rest API
                Mysql


Steps for implementing Djnago with Mysql assuming you have already install Mysql server-

1. First thing we will need to do is install Python 3 database connector. Run the following command

    ```
    sudo apt-get install python3-dev

    ```

    ```
    sudo apt-get install python3-dev libmysqlclient-dev

    ```
    ```
    sudo pip3 install mysqlclient

    ```

2. Add the following to your Djnago project's settings.py file -

   ```
         DATABASES = {
          'default': {
              'ENGINE': 'django.db.backends.mysql',
              'OPTIONS': {
                  'read_default_file': '/etc/mysql/my.cnf',
              },
          }
      }
   ```

3. Open the Mysql 'my.cnf' file and add the following -

  Open the file -

    ```
    sudo nano /etc/mysql/my.cnf

    ```
  Add to file -

      ```
      [client]
      database = db_name
      user = db_user
      password = db_password
      default-character-set = utf8
      ```
4. Finally run the following commands

   ```
   sudo systemctl daemon-reload
   sudo systemctl restart mysql
   ```
