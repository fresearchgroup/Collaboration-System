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
* [Celery](https://pypi.org/project/django-celery/)
* [RabbitMQ](https://github.com/rabbitmq/rabbitmq-server)

## Installation 

For three Step Installation use Docker: [Install](https://github.com/fresearchgroup/Collaboration-System/blob/n-level/install.md)

<p align="center"><img src="/temp/demo.gif?raw=true"/></p>






### Event Logging
To set-up event logging for this system, please refer to the installation steps given in the repository link given below:
https://github.com/fresearchgroup/Collaboration-System-Event-Logs

### Interactive Content (H5P) and Real-time editing
To create and edit interactive content (H5P) and to enable real-time collaborative editing of articles, please refer to the installation steps given in the repository link given below:
https://github.com/fresearchgroup/Community-Content-Tools

### Recommendation System
This system is used to recommend articles based on his/her activity in the sytem. Please refer to the installation steps given in the repository below:
https://github.com/fresearchgroup/Community-Recommendation

### APIs 

	1. /api/community/list/
		-- Method Allow : GET
		-- This api returns a list of communities in the system.

	2. /api/community/<COMMUNITY-ID>/articles/
		--  Method Allow : GET
		--  COMMUNITY-ID is the id of a particular community.
		--  This api returns a list published articles of a particular community.

	3. /api/community/<COMMUNITY-ID>/media/<MEDIA-TYPE>/
		--  Method Allow : GET
		--  COMMUNITY-ID is the id of a particular community.
		--  MEDIA-TYPE is the type of media content that the api will return. Options are - IMAGE, AUDIO, VIDEO
		--  This api returns a list of published media of particular type (eg: IMAGE, AUDIO, VIDEO) in a community.



