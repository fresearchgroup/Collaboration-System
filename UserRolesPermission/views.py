from django.contrib.auth import login as auth_login
from django.shortcuts import render, redirect
from Community.models import CommunityMembership
from BasicArticle.models import Articles
from django.contrib.auth.models import Group
from .forms import SignUpForm

def signup(request):
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            user = form.save()
            g = Group.objects.get(name='Author')
            g.user_set.add(user)
            auth_login(request, user)
            return redirect('user_dashboard')
    else:
        form = SignUpForm()
    return render(request, 'signup.html', {'form': form})

def user_dashboard(request):
    if request.user.is_authenticated:
        communities = CommunityMembership.objects.filter(user=request.user)
        return render(request, 'userdashboard.html', {'communities': communities})
    else:
        return redirect('login')



def home(request):
    articles = Articles.objects.all()[:3]
    return render(request, 'home.html', {'articles':articles})
