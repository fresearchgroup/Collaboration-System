from .models import *
from django.shortcuts import render_to_response, render, redirect
from django.core.exceptions import *
from django.contrib.auth.models import User

##################Validate Email is existing or not in database#######################
def validateemailid(email):
    try:
        print(email)
        email_obj = User.objects.get(email=email)
        if email_obj:
	    
            return email_obj.id
            print("email:",email.obj.id)    
        else:
            return -1
    except:
           return -1





def validateEmail(email):
    if len(email) > 4:
        if re.match("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$", email) != None:
            return 1
    return 0

