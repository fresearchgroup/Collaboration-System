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

def sendEmail_contributor_content_curated(to, status, section, pow, comments, url):
	if status == 'markreview':
		subject = "Your contribution in " + section + " section of " + pow + " has been taken up for curation"
		text_content = "Dear Contributor, \n\n \
			Your contribution in the " + section + " section of the " + pow + \
			"has been taken up for curation. You will no longer be able to edit it unless the curator sends it back to you for modification. " + \
			"Click " + url + " to view your contribution."
		html_content = "<p>Dear Contributor, </p>\n\n \
			<p>Your contribution in the " + section + " section of the " + pow + \
			"has been taken up for curation. You will no longer be able to edit it unless the curator sends it back to you for modification. " + \
			"Click <a href='" + url +"'>here</a> to view your contribution.</p>"
	if status == 'accept':
		subject = "Your contribution is accepted in " + section + " section of " + pow
		text_content = "Dear Contributor, \n\n \
			Your contribution in the " + section + " section of the " + pow + \
			"has passed the first review. Click " + url + " to view your contribution. You will be notified when it is published."
		html_content = "<p>Dear Contributor, </p> \
			<p>Your contribution in the " + section + " section of the " + pow + \
			"has passed the first review . Click <a href='" + url +"'>here</a> to view your contribution. You will be notified when it is published.</p>"
	if status == 'modify':
		subject = "Update your contribution in " + section + " section of " + pow
		text_content = "Dear Contributor, \n\n \
			Please update your contribution in the " + section + " section of the " + pow + \
			" based on the following comments given by the curator. Click " + url + " to view your contribution. \n\n" + comments
		html_content = "<p>Dear Contributor, </p> \
			<p>Please update your contribution in the " + section + " section of the " + pow + \
			" based on the following comments given by the curator.</p> Click <a href='" + url +"'>here</a> to view your contribution.</p>" + \
			"<p><b>Comments</b> <br />" + comments + "</p>"
	if status == 'reject':
		subject = "Your contribution in " + section + " section of " + pow + " cannot be accepted"
		text_content = "Dear Contributor, \n\n \
			Your contribution in the " + section + " section of the " + pow + \
			"cannot be accccepted based on the following comments given by the curator. Click " + url + " to view your contribution. \n\n" + comments
		html_content = "<p>Dear Contributor, </p> \
			<p>Your contribution in the " + section + " section of the " + pow + \
			"cannot be accepted based on the following comments given by the curator.</p> Click <a href='" + url +"'>here</a> to view your contribution.</p>" + \
			"<p><b>Comments</b> <br />" + comments + "</p>"
	sendEmail(subject, to, text_content, html_content)

def sendEmail_curator_new_curator_contributions(to, uname, pow):
	subject = "New curator for " + pow
	text_content = "Dear curator, \n\n \
		Curator named " + uname + " has taken up the curation activity of " + pow + " which was originally assgined to you "
	html_content = "<p>Dear curator, </p> \
		<p>Curator named " + uname + " has taken up the curation activity of " + pow + " which was originally assgined to you </p>"
	sendEmail(subject, to, text_content, html_content)

