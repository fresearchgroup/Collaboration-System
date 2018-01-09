from django.shortcuts import render, redirect
from .models import States, Transitions
from django.contrib.auth.models import Group as Roles
from Basic.models import Articles
# Create your views here.

def workflow(pk, current_state, to_state,  role, belongs_to):
	article = Articles.objects.get(pk=pk)
	if belongs_to == 'community':
		if role == 'publisher':
			current_state = States.objects.get(name=current_state)
			to_state = States.objects.get(name=to_state)
			if article.state == to_state:
				return 
			elif article.state == 'publish':
				return 
			else:
				try:
					transitions = Transitions.objects.get(from_state=current_state, to_state=to_state)
					article.state = to_state
					article.save(update_fields=["state"])
					return 
				except Transitions.DoesNotExist:
					return 

		elif role == 'author':
			return 

	elif belongs_to == 'group':
		return 


