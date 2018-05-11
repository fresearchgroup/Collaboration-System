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

For development installation - 

        1. Install virtualenv 

                ``` sudo pip3 install virtualenv ```

        2. Clone the project from github

                ``` git clone https://github.com/fresearchgroup/Collaboration-System.git ```

        3. Create a virtual env --- 

        ``` virtualenv collab -p python3 ```

        4. Activate the virtual environment -- 

        ``` source collab/bin/activate ```

        5. Install the requirements.txt -- 

        ``` pip3 install -r Collaboration-System/requirements.txt ```

        6. Install mysql server -- 

         ``` https://fresearchgroup.github.io/docs-collaboration-system/docs/mysql.html ```

        7. Provide the Database details at Collaboration-System/Collaboration-System/settings.py

For manual installtion -- https://fresearchgroup.github.io/docs-collaboration-system/

For automated installation using nginx and gunicorn- https://github.com/abhisgithub/django-nginx-installation-script

