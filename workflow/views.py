from django.shortcuts import render, redirect
from django.contrib import messages
from workflow.models import States, Transitions
from django.contrib.auth.models import Group as Roles

def canEditResourceCommunity(state, role, resource, request):
	if state=='publishable' and role=='author':
		messages.warning(request, 'Since it is publishable only the publishers can edit this')
		return False
	if state=='publishable' and request.user == resource.created_by:
		messages.warning(request, 'You cannot edit your own content when it is in publishable state')
		return False
	if state=='publish':
		messages.warning(request, 'You cannot edit content which is already published')
		return False
	return True

def getStatesCommunity(current_state, role):
	state_query = Transitions.objects.value_list(role=role, from_state=current_state) 
	states = []
	for value in state_query:
	    states.append(value[0])
	return states

def getAllStates(request):
	state_query = States.objects.all()
	states = []
	roles = []
	roles_query = Roles.objects.all()
	for role in roles_query:
	    roles.append(role.name)
	for value in state_query:
	    states.append(value.name)
	return render(request, 'transition.html', {'states':states, 'roles':roles})

def createTransitions(request):
	if request.method == 'POST':
		state_query = States.objects.all()
		states = []
		roles = []
		role_ids = dict()
		state_ids = dict()
		roles_query = Roles.objects.all()
		for role in roles_query:
			roles.append(role.name)
			role_ids[role.name] = role.id
		for value in state_query:
			states.append(value.name)
			state_ids[value.name] = value.id


		for role in roles:
			for state_from in states:
				for state_to in states:
					if request.POST.get(role+'-'+state_from+'-'+state_to, False):
						role_id = role_ids[role]
						from_state_id = state_ids[state_from]
						to_state_id = state_ids[state_to]

						transition = Transitions.objects.get_or_create(name=role+'-'+state_from+'-'+state_to, 
									     from_state_id=from_state_id,
									     to_state_id=to_state_id,
									     role_id=role_id)
			

		return render(request, 'transition.html', {'states':states, 'roles':roles}) 

def get_initial_state():
	return States.objects.get(initial=True).pk