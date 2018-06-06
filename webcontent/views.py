from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from .models import Feedback, Faq, FaqCategory

def FAQs(request):
	faqs=Faq.objects.all().order_by('flow')
	categories = FaqCategory.objects.all()
	return render(request, 'FAQs.html',{'faqs':faqs,'categories':categories})

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

def contact_us(request):
	return render(request, 'contact.html')

def create_faq(request):
	if request.method == 'POST':
		question = request.POST['question']
		answer = request.POST['answer']
		flow = request.POST['flow']
		category = request.POST['category']
		cat = FaqCategory.objects.get(name=category)
		faq = Faq.objects.create(
			question=question,
			answer=answer,
			flow = flow,
			category = cat
			)
		return redirect('create_faq')
	else:
		categories=FaqCategory.objects.all()
		return render(request, 'new_faq.html', {'categories':categories})
