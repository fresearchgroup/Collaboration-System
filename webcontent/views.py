from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from .models import Feedback, Faq, FaqCategory
from django.core.mail import EmailMultiAlternatives

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

def sendEmail(subject, to, text_content, html_content):
	signature_text = "\n\n Thank you \n\n PoW team"
	signature_html = "<p>Thank you</p> <p>PoW team</p>"
	text_content += signature_text
	html_content += signature_html
	from_email = 'pow@cse.iitb.ac.in'
	msg = EmailMultiAlternatives(subject, text_content, from_email, [to])
	msg.attach_alternative(html_content, "text/html")
	msg.send()

def sendEmail_contributor_contribution_submitted(to, type, section, pow, url):
	subject = 'thank you for your submission'
	text_content = "Dear Contributor, \n\n \
         Thank you for your submission in the " + section + " section of the " + pow + ". The curators will start reviewing and shall get back to you."
	html_content = "<p>Dear Contributor, </p> \
         <p>Thank you for your submission in the " + section + " section of the " + pow + ". The curators will start reviewing and shall get back to you.</p>"

	sendEmail(subject, to, text_content, html_content)

def sendEmail_curator_contribution_submitted(to, type, section, pow, url):
	subject = 'curate content'
	text_content = "Dear Curator, \n\n \
    	A contribution (" + type + ") has been submitted under the " + \
		section + " section of " + pow + ". Click " + url + " to view it and start curating."
	html_content = "<p>Dear Curator, </p> <p>A contribution (" + type + ") has been submitted under the " + \
		section + " section of " + pow + ". Click <a href='" + url +"'>here</a> to view it and start curating. </p>"  
	sendEmail(subject, to, text_content, html_content)
