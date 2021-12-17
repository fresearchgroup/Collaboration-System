from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from .models import Feedback, Faq, FaqCategory
from django.core.mail import EmailMultiAlternatives
from Community.models import Community

def FAQs(request):
	faqs=Faq.objects.all().order_by('flow')
	categories = FaqCategory.objects.all()
	return render(request, 'FAQs.html',{'faqs':faqs,'categories':categories})

def provide_feedback(request, pk):
	if request.user.is_authenticated:
		community = Community.objects.get(pk=pk)
		if request.method == 'POST':
			title = request.POST['title']
			body  = request.POST['body']
			user = request.user
			feedback = Feedback.objects.create(
				title = title,
				body  = body,
				user = user,
				community = community
				)
			message = 'Your feedback was successfully submitted for' + community.name
			return render(request, 'feedback.html', {'message':message})
		else:
			return render(request, 'feedback.html', {'community':community})
	else:
		return redirect('login')

def view_feedback(request):
	if request.user.is_authenticated:
		u = User.objects.get(username=request.user)
		if u.groups.filter(name='curator').exists() or u.groups.filter(name='icpapprover').exists():
			feedback = Feedback.objects.all().order_by('community')
			return render(request, 'view_feedback.html', {'feedback':feedback})
		else:
			return redirect('user_dashboard')
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
	msg = EmailMultiAlternatives(subject, text_content, from_email, to)
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



def sendEmail_merged_content_curated(to, from_email, status, pow, comments, url, publishedlink, filepath):

	if status == 'sentForReview':
		subject = "Contributions for " + pow + " are ready for review"
		text_content = "Dear ICP Reviewer, \n\n \
			Contributions under the " + pow + " have been collated. Requesting to you kindly review the attached .docx file, provide comments, and email the file back to this email address."
		html_content = "<p>Dear ICP Reviewer,</p> \
			<p>Contributions under the " + pow + " have been collated. Requesting to you kindly review the attached .docx file, provide comments, and email the file back to this email address.</p>"

	if status == 'sentForApproval':
		subject = "Contributions for " + pow + " are ready for approval"
		text_content = "Dear ICP Approver, \n\n \
			Contributions under the " + pow + " have been collated. Requesting to you kindly review the attached .docx file, provide comments, and email the file back to this email address."
		html_content = "<p>Dear ICP Approver,</p> \
			<p>Contributions under the " + pow + " have been collated. Requesting to you kindly review the attached .docx file, provide comments, and email the file back to this email address.</p>"

	if status == 'recurate':
		subject = "Recurate contributions of " + pow
		text_content = "Dear Curator, \n\n \
			Please re-curate the contribution of the " + pow + \
			" based on the following comments given by the curator. Click " + url + " to view. \n\n" + comments
		html_content = "<p>Dear Curator,</p> \
			<p>Please re-curate the contribution of the " + pow + \
			" based on the following comments given by the curator. \
			Click <a href='" + url +"'>here</a> to view. </p>" \
			"<p><b>Comments</b></p><p>" + comments + "</p>"

	if status == 'accept':
		subject = "Contributions of " + pow + " have been accepted"
		text_content = "Dear Curator, \n\n \
			The contributions of " + pow + " have been accepted by the ICP approver. Click " + url + " to view."
		html_content = "<p>Dear Curator,</p> \
			<p>The contributions of " + pow + " have been accepted by the ICP approver. \
			Click <a href='" + url +"'>here</a> to view.</p>"

	if status == 'publishedonicp':
		subject = "Contributions of " + pow + " have been published on the ICP"
		text_content = "Dear Contributor, \n\n \
			The contributions of " + pow + " have been published on the ICP. Click " + publishedlink + " to view."
		html_content = "<p>Dear Contributor,</p> \
			<p>The contributions of " + pow + " have been published on the ICP. \
			Click <a href='" + publishedlink +"'>here</a> to view.</p>"
		
	signature_text = "\n\n Thank you \n\n PoW team"
	signature_html = "<p>Thank you</p> <p>PoW team</p>"
	text_content += signature_text
	html_content += signature_html
	msg = EmailMultiAlternatives(subject, text_content, from_email, to)
	msg.attach_alternative(html_content, "text/html")
	if status == 'sentForReview' or status == 'sentForApproval':
		msg.attach_file(filepath)
	msg.send()

def sendEmail_contributor_pow_request_submitted(to):
	subject = 'thank you for submitting request for creating a new Place of worship'
	text_content = "Dear Contributor, \n\n Thank you for submitting request for creating a new Place of Worship . The curators will start reviewing and shall get back to you."
	html_content = "<p>Dear Contributor,</p> <p>Thank you for submitting request for creating a new Place of Worship . The curators will start reviewing and shall get back to you.</p>"
	sendEmail(subject, to, text_content, html_content)

def sendEmail_curator_pow_request_submitted(to):
	subject = 'Request for creating a new Place of Worship'
	text_content = "Dear Curator, \n\n Contributor has rasised a request for creating a new place of worship. Kindly go through it."
	html_content = "<p>Dear Curator,</p> <p>Contributor has rasised a request for creating a new place of worship. Kindly go through it.</p>"
	sendEmail(subject, to, text_content, html_content)

def sendEmail_curate_new_pow(to, pow, parent, reason, uname, status):
	if status == 'changeassignee':
		subject = "New curator for curating requests for new place of worship, " + pow
		text_content = "Dear curator, \n\n \
			Curator named " + uname + " has taken up the curation activity for curating requests of a new place of worship " + pow + " which was originally assgined to you "
		html_content = "<p>Dear curator, </p> \
			<p>Curator named " + uname + " has taken up the curation activity for curating requests of a new place of worship " + pow + " which was originally assgined to you </p>"

	if status == 'accept':
		subject = 'Your requested place of worship has been created'
		text_content = "Dear Contributor, \n\n \
			The place of worship, " + pow + ", that you had requested has been accepted and created under " + parent + "." \
			"You can now start contributing under the respective sections."
		html_content = "<p>Dear Contributor,</p> \
			<p>The place of worship, " + pow + ", that you had requested has been accepted and created under " + parent + "." \
			"You can now start contributing under the respective sections.</p>"

	if status == 'modify':
		subject = "Update your details for the new place of worship requested by you"
		text_content = "Dear Contributor, \n\n \
			Please update the details given by you for the creation of a new place of worship (" + pow + ") based on the following comments given by the curator." \
			"\n\nComments \n " + reason
		html_content = "<p>Dear Contributor,</p> \
			<p>Please update the details given by you for the creation of a new place of worship (" + pow + ") based on the following comments given by the curator.</p>" \
			"<p><b>Comments</b></p><p>" + reason + "</p>"

	if status == 'rejected':
		subject = "Cannot create the requested place of worship" + pow
		text_content = "Dear Contributor, \n\n \
			The requested place of worship " + pow + " cannot be created due to the following reasons given by the curator. \n\n" \
			+ reason
		html_content = "<p>Dear Contributor,</p> \
			<p>The requested place of worship " + pow + " cannot be created due to the following reasons given by the curator. </p>" \
			"<p>" + reason + "</p>"

	sendEmail(subject, to, text_content, html_content)


