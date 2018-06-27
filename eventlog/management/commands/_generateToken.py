from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
import sys
from django.contrib.auth import authenticate
from django.conf import settings
from decouple import config
 
class GetToken:

    def __init__(self):
        print("called get token new")
        self.details = self.make_details()

    def make_details(self):
        details = {'username': "", "password": ""}
        try:
            details['username'] = config('EVENTAPI_TOKEN_USERNAME')
            details['password'] = config('EVENTAPI_TOKEN_PASSWORD')
        except KeyError as k:
            print("Error occured: {!s}".format(k))
        return details
 
    def checkUserExistence(self):
        user = User.objects.filter(username=self.details['username'])
        if user:
            return user[0]
        else:
            return False

    def addNewUser(self):
        user = User.objects.create(username=self.details['username'], password=self.details['password'])
        user.save()
        return user

    def renewToken(self):
        if self.checkUserExistence() is False:
            print("User does not exists. Use without --n flag to generate a new user and a token")
        else:
            user = User.objects.filter(username=self.details['username'])
            token = Token.objects.filter(user = user).delete()
            return self.generateNewToken(force=True)
    
    def generateNewToken(self, force = False):
        user = self.checkUserExistence()
        print(user)
        if user and force is False:
            print("User already exists. Use --r to renew token")
        else:
            if user is False:
                user = self.addNewUser()
            token = Token.objects.create(user = user)
            print("Token for {!s}: {!s}".format(self.details['username'], token.key))
            return token.key

    def getTokenValue(self):
        user = self.checkUserExistence()
        if user is False:
            print("User does not exists. Use without --n flag to generate a new user and a token")
        else:
            token = Token.objects.filter(user=user)[0]
            print("Token for {!s}: {!s}".format(user.username, token.key))
            return token.key
