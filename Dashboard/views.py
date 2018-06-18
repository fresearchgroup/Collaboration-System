from django.shortcuts import render, redirect


def community_dashboard(request,pk):
    return render(request, 'community_dashboard.html')

def article_dashboard(request,pk):
	return render(request,'article_dashboard.html')

def user_insight_dashboard(request,pk):
	return render(request,'user_insight_dashboard.html')
