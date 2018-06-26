from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
import sys
from django.contrib.auth import authenticate
from django.conf import settings
from decouple import config
import os
import django
 
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "project.settings")
django.setup()

class GetToken:

    def __init__(self):
        self.details = self.make_details()

    def make_details(self):
        details = {'username': "", "password": ""}
        try:
            details['username'] = config('EVENTAPI_TOKEN_USERNAME')
            details['password'] = config('EVENTAPI_TOKEN_PASSWORD')
        except KeyError as k:
            print("Error occured: {!s}".format(k))
 
    def checkUserExistence(self):
        user = User.objects.get(username=self.details['username'])
        if user:
            return True
        else:
            return False

    def addNewUser(self):
        user = User.objects.create(username=self.details['username'], password=self.details['password'])
        user.save()
        return user

    def renewToken(self):
        if self.checkUserExistence() == False:
            print("User does not exists. Use without -r flag to generate a new user and a token")
        else:
            user = User.objects.filter(username=self.details['username'])
            token = Token.objects.filter(user = user).delete()
            self.generateNewToken()
    
    def generateNewToken(self):
        if self.checkUserExistence() == True:
            print("User already exists. Use -r to renew token")
        else:
            token = Token.objects.create(user = self.addNewUser())
            print("Token for {!s}: {!s}".format(self.details['username'], token.key))

    def getTokenValue(self):
        if self.checkUserExistence() == False:
            print("User does not exists. Use without -r flag to generate a new user and a token")
        else:
            user = User.objects.filter(username=self.details['username'])
            token = Token.objects.filter(user=user)
            print("Token for {!s}: {!s}".format(user.username, token.key))
