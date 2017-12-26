from django.contrib.auth import login as auth_login
from django.shortcuts import render, redirect
from Community.models import CommunityMembership, CommunityArticles, CommunityGroups
from BasicArticle.models import Articles
from .forms import SignUpForm
from .roles import Author
from rolepermissions.roles import assign_role
from Group.models import GroupMembership, GroupArticles

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
        communities = CommunityMembership.objects.filter(user=request.user)
        groups = GroupMembership.objects.filter(user=request.user)

        commarticles = CommunityArticles.objects.filter(user=request.user)
        grparticles = GroupArticles.objects.filter(user=request.user)

        cgroups = CommunityGroups.objects.filter(user=request.user)

        return render(request, 'userdashboard.html', {'communities': communities, 'groups':groups, 'commarticles':commarticles, 'grparticles':grparticles, 'cgroups':cgroups })
    else:
        return redirect('login')



def home(request):
    articles = Articles.objects.all()[:3]
    return render(request, 'home.html', {'articles':articles})
