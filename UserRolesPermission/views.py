from django.contrib.auth import login as auth_login
from django.shortcuts import render, redirect
from Community.models import CommunityMembership, CommunityArticles, CommunityGroups, RequestCommunityCreation
from BasicArticle.models import Articles
from .forms import SignUpForm
from .roles import Author
from rolepermissions.roles import assign_role
from Group.models import GroupMembership, GroupArticles, Group
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

def signup(request):
    """
    this is a sign up function for new user in the system.  The function takes
    user input, validates it, register the user , and gives an Author role to the user.
    """
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():

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
                return render(request, 'signup.html', {'form': form, 'error':error})
    else:
        form = SignUpForm()
    return render(request, 'signup.html', {'form': form})

def user_dashboard(request):
    if request.user.is_authenticated:
        try:
            user_profile = ProfileImage.objects.get(user=request.user)
        except ProfileImage.DoesNotExist:
            user_profile = "No Image available"

        mycommunities = CommunityMembership.objects.filter(user=request.user).order_by('community__name')
        page = request.GET.get('page', 1)
        paginator = Paginator(mycommunities, 5)
        try:
            communities = paginator.page(page)
        except PageNotAnInteger:
            communities = paginator.page(1)
        except EmptyPage:
            communities = paginator.page(paginator.num_pages)

        mygroups = GroupMembership.objects.filter(user=request.user).order_by('group__name')
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
        visiblelist = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        publishablelist = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
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
        return render(request, 'userdashboard.html', {'communities': communities, 'groups':groups, 'commarticles':commarticles, 'grparticles':grparticles, 'pendingcommunities':pendingcommunities,'articlescontributed':list(articlescontributed),'articlespublished':articlespublished, 'total':total, 'user_profile':user_profile})
    else:
        return redirect('login')

def home(request):
	state = States.objects.get(name='publish')
	articles=Articles.objects.filter(state=state).order_by('-views')[:3]
	articlesdate=Articles.objects.filter(state=state).order_by('-created_at')[:3]
	community=Community.objects.all().order_by('?')[:4]
	userphoto=ProfileImage.objects.all().order_by('?')[:15]
	countcommunity = Community.objects.all().count()
	countgroup = Group.objects.all().count()
	countarticles = Articles.objects.filter(state=state).count()
	countusers = User.objects.all().count()
	return render(request, 'home.html', {'articles':articles, 'articlesdate':articlesdate, 'community':community, 'userphoto':userphoto, 'countcommunity':countcommunity, 'countgroup':countgroup, 'countarticles':countarticles, 'countusers':countusers})

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
        groups = GroupMembership.objects.filter(user=userinfo)
        commarticles = CommunityArticles.objects.filter(user=userinfo)
        grparticles = GroupArticles.objects.filter(user=userinfo)
        try:
            user_profile = ProfileImage.objects.get(user=userinfo)
        except ProfileImage.DoesNotExist:
            user_profile = "No Image available"
        return render(request, 'userprofile.html', {'userinfo':userinfo, 'communities':communities, 'groups':groups, 'commarticles':commarticles, 'grparticles':grparticles, 'user_profile':user_profile})
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