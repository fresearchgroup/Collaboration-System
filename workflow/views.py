from django.shortcuts import render, redirect
from django.contrib import messages


def canEditResourceCommunity(state, role, resource, request):
	if state=='publishable' and role=='author':
		messages.warning(request, 'Since it is publishable only the publishers can edit this')
		return False
	if state=='publishable' and request.user == resource.created_by:
		messages.warning(request, 'You cannot edit your own content when it is publishable state')
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

def canEditResourceGroup(state, grouprole, commrole, resource, request):
	errormessage = 'True'
	if state=='visible':
		errormessage = 'The content is shared with the community. Only the community publishers and admin can edit this.'
	if state=='visible' and commrole == 'author':
		errormessage = 'The content is shared with the community. Only the community publishers and admin can edit this.'
	if state=='visible' and (commrole == 'publisher' or commrole == 'community_admin'):
		errormessage = 'True'
	if state=='visible' and request.user == resource.created_by:
		errormessage = 'You cannot edit your own content as it is shared with the community. Only the other community publishers and admin can edit this.'
	if state=='publish':
		errormessage = 'You cannot edit content which is already published'
	return errormessage

def getStatesGroup(current_state, role):
	states = []
	if current_state == 'draft':
		states.append("draft")
		states.append("private")
	if current_state == 'private' and role == 'author':
		states.append("private")
	if current_state == 'private' and (role == 'publisher' or role =='group_admin'):
		states.append("private")
		states.append("visible")
	if current_state == 'visible':
		states.append("private")
		states.append("visible")
		states.append("publish")
	return states
