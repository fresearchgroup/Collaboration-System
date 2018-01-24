from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from .models import Feedback

def FAQs(request):
	return render(request, 'FAQs.html')

def provide_feedback(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			title = request.POST['title']
			body  = request.POST['body']
			user = request.user
			feedback = Feedback.objects.create(
				title = title,
				body  = body,
				user = user
				)
			message = 'Your feedback was successfully submitted!'
			return render(request, 'feedback.html', {'message':message})
		else:
			return render(request, 'feedback.html')
	else:
		return redirect('login')
