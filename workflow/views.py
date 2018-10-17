from django.shortcuts import render, redirect



def canEditResourceCommunity(state, role, resource, request):
	errormessage = 'True'
	if state=='publishable' and role=='author':
		errormessage = 'Since it is publishable only the publishers can edit this'
	if state=='publishable' and request.user == resource.created_by:
		errormessage = 'You cannot edit your own content when it is publishable state'
	if state=='publish':
		errormessage = 'You cannot edit content which is already published'
	return errormessage

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
