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