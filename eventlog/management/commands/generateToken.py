from django.core.management.base import BaseCommand, CommandError
from rest_framework.authtoken.models import Token
import sys
from django.contrib.auth import authenticate
from django.conf import settings
from decouple import config
from ._generateToken import GetToken


class Command(BaseCommand):
    help = 'generates a new token'
    
    def add_arguments(self, parser):
        print("adding arguments")
        #parser.add_argument('-r', i#);
        parser.add_argument('--r', 
                action='store_true',
                dest="renew", 
                help="renew the token"
                )
        parser.add_argument('--g',
                action='store_true',
                dest="get", 
                help="renew the token"
                )
        parser.add_argument('--n',
                action='store_true',
                dest="new", 
                help="generate new the token"
                )

    def handle(self, *args, **options):
        gt = GetToken()
        if options['renew']:
            gt.renewToken()
        elif options['get']:
            gt.getTokenValue()
        elif options['new']:
            gt.generateNewToken()
        else:
            print("options not specified")
