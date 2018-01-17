from django.contrib.auth import login as auth_login
from django.shortcuts import render, redirect
from Community.models import CommunityMembership, CommunityArticles, CommunityGroups, RequestCommunityCreation
from BasicArticle.models import Articles
from .forms import SignUpForm
from .roles import Author
from rolepermissions.roles import assign_role
from Group.models import GroupMembership, GroupArticles
from django.contrib.auth.models import User
from workflow.models import States
from Community.models import Community
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from UserRolesPermission.validate import validateemailid
from django.core.mail import send_mail
from django.template.context_processors import csrf
from django.http import HttpResponseRedirect, HttpResponse
from CollaborationSystem.settings import *
from django.template import *
from django.template import loader
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.contrib.auth.tokens import default_token_generator
from django.utils.encoding import force_bytes
from django.contrib.auth.models import User
from django.contrib.auth.hashers import (UNUSABLE_PASSWORD_PREFIX, identify_hasher)
from django.utils.http import urlsafe_base64_encode
from django.utils.safestring import mark_safe
from django.contrib.sites.shortcuts import get_current_site
from django.contrib.auth import authenticate, get_user_model
from django.contrib import messages
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import PasswordChangeForm
from django.shortcuts import render, redirect
from django.core import validators

from operator import add
def signup(request):
    """
    this is a sign up function for new user in the system.  The function takes
    user input, validates it, register the user , and gives an Author role to the user.
    """
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            user = form.save()
            assign_role(user, Author)
            auth_login(request, user)
            return redirect('user_dashboard')
    else:
        form = SignUpForm()
    return render(request, 'signup.html', {'form': form})

def user_dashboard(request):
    if request.user.is_authenticated:
        mycommunities = CommunityMembership.objects.filter(user=request.user)
        page = request.GET.get('page', 1)
        paginator = Paginator(mycommunities, 5)
        try:
            communities = paginator.page(page)
        except PageNotAnInteger:
            communities = paginator.page(1)
        except EmptyPage:
            communities = paginator.page(paginator.num_pages)

        mygroups = GroupMembership.objects.filter(user=request.user)
        page = request.GET.get('page2',1)
        paginator = Paginator(mygroups, 5)
        try:
            groups = paginator.page(page)
        except PageNotAnInteger:
            groups = paginator.page(1)
        except EmptyPage:
            groups = paginator.page(paginator.num_pages)

        commarticles = CommunityArticles.objects.filter(user=request.user)
        grparticles = GroupArticles.objects.filter(user=request.user)

        pendingcommunities=RequestCommunityCreation.objects.filter(status='Request', requestedby=request.user)

        ap = User.objects.raw(
        'Select 1 id, Year, Sum(JAN) JAN,sum(FEB) FEB,sum(MAR) MAR,sum(APR) APR,sum(MAY) MAY,sum(JUN) JUN,sum(JUL) JUL,sum(AUG) AUG,sum(SEP) SEP,sum(OCT) OCT,sum(NOV) NOV,sum(DECEM) DECE, Concat(Sum(JAN) , "," , sum(FEB) , "," ,sum(MAR),",",sum(APR),",",sum(MAY),",",sum(JUN),",",sum(JUL),",",sum(AUG),",", sum(SEP) ,",",sum(OCT),",",sum(NOV),",",sum(DECEM)) Data,state_id State from (Select Year, Case when Month=1 Then 1 else 0 END JAN, Case when Month=2 Then 1 else 0 END FEB, Case when Month=3 Then 1 else 0 END MAR, Case when Month=4 Then 1 else 0 END APR, Case when Month=5 Then 1 else 0 END MAY, Case when Month=6 Then 1 else 0 END JUN, Case when Month=7 Then 1 else 0 END JUL, Case when Month=8 Then 1 else 0 END AUG, Case when Month=9 Then 1 else 0 END SEP, Case when Month=10 Then 1 else 0 END OCT, Case when Month=11 Then 1 else 0 END NOV, Case when Month=12 Then 1 else 0 END DECEM, state_id from  (select  Month(created_at) Month ,Year(created_at) Year ,state_id from BasicArticle_articles where id in (select article_id from Community_communityarticles where user_id=%s) or id in (select article_id from Group_grouparticles where user_id=%s)) T ) P group by Year,state_id having Year=2018;',
        [request.user.id,request.user.id] )
        visiblelist = []
        publishablelist = []
        articlespublished = ''
        for a in ap:
            if a.State == 3: #publsihed
                articlespublished=a.Data
            if a.State == 2: # visible
                visiblelist = str(bytes.decode(a.Data)).split(',')
                visiblelist = list(map(int, visiblelist))
            if a.State == 5: #publishable
                publishablelist = str(bytes.decode(a.Data)).split(',')
                publishablelist = list(map(int, publishablelist))

        articlescontributed = map(add, visiblelist, publishablelist)
        articlescontributed = list(map(str, articlescontributed))
        total = ''
        for a in articlescontributed:
            total = total + ',' + a
        total=total[1:]
        return render(request, 'userdashboard.html', {'communities': communities, 'groups':groups, 'commarticles':commarticles, 'grparticles':grparticles, 'pendingcommunities':pendingcommunities,'articlescontributed':list(articlescontributed),'articlespublished':articlespublished, 'total':total})
    else:
        return redirect('login')

def home(request):
	state = States.objects.get(name='publish')
	articles=Articles.objects.filter(state=state).order_by('-views')[:3]
	articlesdate=Articles.objects.filter(state=state).order_by('-created_at')[:3]
	community=Community.objects.all().order_by('?')[:3]
	return render(request, 'home.html', {'articles':articles, 'articlesdate':articlesdate, 'community':community})

def update_profile(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			first_name = request.POST['first_name']
			last_name = request.POST['last_name']
			email = request.POST['email']
			uid = request.user.id
			usr = User.objects.get(pk = request.user.id)
			usr.email=email
			usr.first_name=first_name
			usr.last_name=last_name
			usr.save()
			return redirect('user_dashboard')
		else:
			return render(request, 'update_profile.html')
	else:
		return redirect('login')

def view_profile(request):
	if request.user.is_authenticated:
		return render(request, 'myprofile.html')
	else:
		return redirect('login')

def display_user_profile(request, username):
    if request.user.is_authenticated:
        userinfo = User.objects.get(username=username)
        communities = CommunityMembership.objects.filter(user=userinfo)
        groups = GroupMembership.objects.filter(user=userinfo)
        commarticles = CommunityArticles.objects.filter(user=userinfo)
        grparticles = GroupArticles.objects.filter(user=userinfo)
        return render(request, 'userprofile.html', {'userinfo':userinfo, 'communities':communities, 'groups':groups, 'commarticles':commarticles, 'grparticles':grparticles})
    else:
        return redirect('login')


def get_users(email):
        """Given an email, return matching user(s) who should receive a reset.

        This allows subclasses to more easily customize the default policies
        that prevent inactive users and users with unusable passwords from
        resetting their password.

        """

        active_users = get_user_model()._default_manager.filter(
            email__iexact=email, is_active=True)
        return (u for u in active_users if u.has_usable_password())





def forgot_password(request):
    args = {}

    args.update(csrf(request))
    token_generator=default_token_generator
    domain_override=None
    #context={}
    if request.method == 'POST':

        email = request.POST['email']

        email_valid=validateemailid(email)
        #username=User.objects.get(email=email).username
        #user=email
        #print("success",user)
        for user in get_users(email):
            if not domain_override:
                current_site = get_current_site(request)
                site_name = current_site.name
                domain = current_site.domain
                #print("user",site_name,domain)
            else:
                site_name = domain = domain_override
            context = {
                'email': email,
                'domain': '127.0.0.1:8000',
                'site_name': '127.0.0.1:8000',
                'uid': urlsafe_base64_encode(force_bytes(user)),
                'user': user,
                'token': token_generator.make_token(user),
                'protocol': 'http',
            }
        print (email_valid)
        if email_valid != -1:

           email_template='password_reset_template.html'
           emailtext = loader.render_to_string(email_template, context)
           ##emaildata=loader.get_template(email_template)
           test=send_mail("Forgot Password", emailtext , DEFAULT_FROM_EMAIL ,[email], fail_silently=False)
           print(test)
           args['email']=email
           return render(request,'password_reset_email.html',args)
        else:
           args['message']="Invalid Email Address"
           return render(request,'forgotpassword.html',args)
    return render(request,'forgotpassword.html',args)

def change_password(request,uidb64,token):
    if request.method == 'POST':
        print("suc",request.user)
        form = PasswordChangeForm(request.user, request.POST)
        if  form.is_valid():
            user = form.save()
            print("jdhh")
            update_session_auth_hash(request, user)  # Important!
            messages.success(request, 'Your password was successfully updated!')
            return render(request,'resetpasswordsuccess.html')
        else:
            messages.error(request, 'Please correct the error below.')
    else:
        form = PasswordChangeForm(request.user)
    return render(request, 'changepassword.html', {
        'form': form
    })


def change_password_success(request):

    return render(request,'resetpasswordsuccess.html')
