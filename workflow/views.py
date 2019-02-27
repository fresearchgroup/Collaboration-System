from django.shortcuts import render, redirect
from django.contrib import messages


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

def getStatesCommunity(current_state):
	states = []
	if current_state == 'draft':
		states.append("draft")
		states.append("visible")
	if current_state == 'visible':
		states.append("visible")
		states.append("publishable")
	if current_state == 'publishable':
		states.append("publishable")
		states.append("visible")
		states.append("publish")
	return states

