from django.contrib.auth import login as auth_login
from django.shortcuts import render, redirect
from Community.models import CommunityMembership, CommunityArticles, RequestCommunityCreation, CommunityCourses, CommunityMedia
from BasicArticle.models import Articles
from .forms import SignUpForm
from .roles import Author
from rolepermissions.roles import assign_role
from django.contrib.auth.models import User
from workflow.models import States
from Community.models import Community
from .models import ProfileImage, favourite
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from operator import add
from django.conf import settings
import urllib
import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse
from django.core import serializers
from datetime import date
from decouple import config
from etherpad.views import create_ether_user
from django.db.models import Q
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.utils import six
from django.contrib.sites.shortcuts import get_current_site
from django.template.loader import render_to_string
from django.core.mail import EmailMessage
from django.contrib import messages as auth_messages
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_text
from Media.models import Media

class TokenGenerator(PasswordResetTokenGenerator):
    def _make_hash_value(self, user, timestamp):
        return (
        six.text_type(user.pk) + six.text_type(timestamp) +
        six.text_type(user.is_active)
        )
account_activation_token = TokenGenerator()

def validateEmail(email):
    from django.core.exceptions import ValidationError
    from django.core.validators import validate_email

    try:
        validate_email(email)
        return True
    except ValidationError as e:
        return False



def send_mail(request, user, to_email):
    current_site = get_current_site(request)
    mail_subject = 'Please activate your account.'
    message = render_to_string('activate_email.html', {
    'user': user,
    'domain': current_site.domain,
    'uid':urlsafe_base64_encode(force_bytes(user.pk)).decode(),
    'token':account_activation_token.make_token(user),
    })
    #print(mail_subject, message, to_email)
    email = EmailMessage(mail_subject, message, to=[to_email])
    email.send(fail_silently=True)



def activate_user(request, uidb64, token):
    try:
        uid = force_text(urlsafe_base64_decode(uidb64))
        user = User.objects.get(pk=uid)
    except(TypeError, ValueError, OverflowError, User.DoesNotExist):
        user = None
    if user is not None and account_activation_token.check_token(user, token):
        user.is_active = True
        user.save()
        auth_messages.success(request, 'Thank you for your email confirmation. You can login to your account now.')
        return redirect('login')
    else:
        return HttpResponse('Activation link is invalid!')


def signup(request):
    """
    this is a sign up function for new user in the system.  The function takes
    user input, validates it, register the user , and gives an Author role to the user.
    """
    Captcha = config('CAPTCHA', cast=bool)

    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():

            if Captcha:
                ''' Begin reCAPTCHA validation '''
                recaptcha_response = request.POST.get('g-recaptcha-response')
                url = 'https://www.google.com/recaptcha/api/siteverify'
                values = {
                    'secret': settings.GOOGLE_RECAPTCHA_SECRET_KEY,
                    'response': recaptcha_response
                }
                data = urllib.parse.urlencode(values).encode()
                req =  urllib.request.Request(url, data=data)
                response = urllib.request.urlopen(req)
                result = json.loads(response.read().decode())
                ''' End reCAPTCHA validation '''

                if result['success']:
                    user = form.save()
                    assign_role(user, Author)
                    auth_login(request, user, backend='django.contrib.auth.backends.ModelBackend')
                    return redirect('user_dashboard')
                else:
                    error = 'Captcha not verified'
                    return render(request, 'signup.html', {'form': form, 'error':error, 'captcha':Captcha})
            else:
                user = form.save(commit=False)
                user.is_active = False
                user.save()
                assign_role(user, Author)
                to_email = form.cleaned_data.get('email')
                send_mail(request, user, to_email)
                if settings.REALTIME_EDITOR:
                    create_ether_user(user)
                auth_messages.success(request, 'Please confirm your email address to complete the registration.')
                return redirect('login')
        else:
            return render(request, 'signup.html', {'form': form, 'captcha':Captcha})
    else:
        form = SignUpForm()
    return render(request, 'signup.html', {'form': form, 'captcha':Captcha})

def user_dashboard(request):
    currentyear=date.today()
    number =[]
    for n in range (2017,currentyear.year+1):
        number.append(n)
    if request.method == 'POST': # If the form has been submitted...
        yearby=request.POST['selectbyyear']
    else :
        today=date.today()
        yearby=today.year

    if request.user.is_authenticated:

        try:
            user_profile = ProfileImage.objects.get(user=request.user)
        except ProfileImage.DoesNotExist:
            user_profile = "No Image available"

        mycommunities = CommunityMembership.objects.filter(user=request.user).order_by('community__name')

        commarticles = CommunityArticles.objects.filter(user=request.user)
        commcourses = CommunityCourses.objects.filter(user=request.user)
        commmedia = CommunityMedia.objects.filter(user=request.user)

        for cart in commarticles:
            cart.type = 'article'
            cart.belongsto = 'community'

        for ccourse in commcourses:
            ccourse.type = 'course'
            ccourse.belongsto = 'community'

        for cmedia in commmedia:
            cmedia.type = 'Media'
            cmedia.belongsto = 'community'

        lstContent = list(commarticles) + list(commmedia) + list(commcourses)

        pendingcommunities=RequestCommunityCreation.objects.filter(status='Request', requestedby=request.user)

        articles = []
        images = []
        audio = []
        video = []
        for i in range(1, 13):
            articles.append(Articles.objects.filter(created_by=request.user, state__initial=False, created_at__year=yearby, created_at__month=i).count())
            images.append(Media.objects.filter(created_by=request.user, mediatype='Image', state__initial=False, created_at__year=yearby, created_at__month=i).count())
            audio.append(Media.objects.filter(created_by=request.user, mediatype='Audio', state__initial=False, created_at__year=yearby, created_at__month=i).count())
            video.append(Media.objects.filter(created_by=request.user, mediatype='Video', state__initial=False, created_at__year=yearby, created_at__month=i).count())
        return render(request, 'userdashboard.html', {'mycommunities':mycommunities, 'commarticles':commarticles, 'pendingcommunities':pendingcommunities,'articles':articles, 'user_profile':user_profile, 'lstContent':lstContent, 'images':images, 'audio':audio, 'video':video})
    else:
        return redirect('login')

def badges_progress_dashboard(request):
    if request.user.is_authenticated:
        return render(request, 'badges_progress_dashboard.html')
    else:
        return redirect('login')

def home(request):
	state = States.objects.get(name='publish')
	articles=Articles.objects.filter(state=state).order_by('-views')[:3]
	articlesdate=Articles.objects.filter(state=state).order_by('-created_at')[:3]
	community=Community.objects.all().order_by('?')[:4]
	userphoto=ProfileImage.objects.all().order_by('?')[:15]
	countcommunity = Community.objects.filter(parent = None).count()
	countsubcomm = Community.objects.filter(~Q(parent = None)).count()
	countarticles = Articles.objects.filter(state=state).count()
	countusers = User.objects.all().count()
	return render(request, 'home.html', {'articles':articles, 'articlesdate':articlesdate, 'community':community, 'userphoto':userphoto, 'countcommunity':countcommunity, 'countsubcomm':countsubcomm, 'countarticles':countarticles, 'countusers':countusers})

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
            try:
                user_profile = ProfileImage.objects.get(user=request.user)
            except ProfileImage.DoesNotExist:
                user_profile = "No Image available"
            return render(request, 'update_profile.html', {'user_profile':user_profile})
    else:
        return redirect('login')

def view_profile(request):
    if request.user.is_authenticated:
        try:
            user_profile = ProfileImage.objects.get(user=request.user)
        except ProfileImage.DoesNotExist:
            user_profile = "No Image available"
        return render(request, 'myprofile.html', {'user_profile':user_profile})
    else:
        return redirect('login')

def display_user_profile(request, username):
    if request.user.is_authenticated:
        userinfo = User.objects.get(username=username)
        communities = CommunityMembership.objects.filter(user=userinfo)
        commarticles = CommunityArticles.objects.filter(user=userinfo)
        try:
            user_profile = ProfileImage.objects.get(user=userinfo)
        except ProfileImage.DoesNotExist:
            user_profile = "No Image available"
        return render(request, 'userprofile.html', {'userinfo':userinfo, 'communities':communities, 'commarticles':commarticles, 'user_profile':user_profile})
    else:
        return redirect('login')


def upload_image(request):

    if request.method == 'POST':
        photo = request.FILES['profile_image']
        try:
            user_profile = ProfileImage.objects.get(user=request.user)
            user_profile.photo = photo
            user_profile.save()

        except ProfileImage.DoesNotExist:
            obj = ProfileImage.objects.create(user = request.user, photo=photo)

        return redirect('view_profile')
    return redirect('view_profile')


def username_exist(request):
    username = request.GET.get('username', None)
    data = {
        'is_taken': User.objects.filter(username__iexact=username).exists()
    }
    if data['is_taken']:
        data['error_message'] = 'A user with this username already exists.'
    return JsonResponse(data)

@csrf_exempt
def favourites(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        user= User.objects.get(username=username)
        resource_id = request.POST.get('rid')
        category = request.POST.get('category')
        status = request.POST.get('status')
        if status == 'add':
            if not favourite.objects.filter(user = user, resource = resource_id, category= category).exists():
                obj = favourite.objects.create(user = user, resource = resource_id, category= category)
                return HttpResponse('added')
        if status == 'remove':
            if  favourite.objects.filter(user = user, resource = resource_id, category= category).exists():
                obj = favourite.objects.filter(user = user, resource = resource_id, category= category).delete()
                return HttpResponse('removed')
        return HttpResponse('ok')


