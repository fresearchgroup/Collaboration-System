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

        return render(request, 'userdashboard.html', {'communities': communities, 'groups':groups, 'commarticles':commarticles, 'grparticles':grparticles, 'pendingcommunities':pendingcommunities,'articlescontributed':'1500,114,106,106,107,2,133,221,783,1123,1345,1634','articlespublished':'900,350,411,502,635,5,947,1102,1400,1267,1674,1987' })
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
