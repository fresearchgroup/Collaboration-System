from django.contrib.auth import login as auth_login
from django.shortcuts import render, redirect
from Community.models import CommunityMembership

from .forms import SignUpForm

def signup(request):
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            user = form.save()
            auth_login(request, user)
            return redirect('dashboard')
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
	return render(request, 'home.html')
