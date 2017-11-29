from django.shortcuts import render, redirect
from django.http import Http404, HttpResponse
from .models import Group, GroupMembership, GroupArticles
from BasicArticle.models import Articles
from BasicArticle.views import create_article, view_article

def create_group(request):
	if request.method == 'POST':
		name = request.POST['name']
		desc = request.POST['desc']
		visibility = request.POST['visibility']
		group = Group.objects.create(
			name = name,
			desc  = desc,
			visibility = visibility
			)
		return group

def group_view(request, pk):
	try:
		group = Group.objects.get(pk=pk)
		uid = request.user.id
		membership = GroupMembership.objects.get(user=uid, group=group.pk)
	except GroupMembership.DoesNotExist:
		membership = 'FALSE'
	subscribers = GroupMembership.objects.filter(group = pk).count()
	contributors = GroupMembership.objects.filter(group = pk)
	return render(request, 'groupview.html', {'group': group, 'membership':membership, 'subscribers':subscribers, 'contributors':contributors})

def group_subscribe(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			gid = request.POST['gid']
			group = Group.objects.get(pk=gid)
			user = request.user
			obj = GroupMembership.objects.create(user=user, group=group)
			return redirect('group_view',pk=gid)
		return render(request, 'groupview.html')
	else:
		return redirect('login')

def group_unsubscribe(request):
	if request.method == 'POST':
		gid = request.POST['gid']
		group = Group.objects.get(pk=gid)
		user = request.user
		obj = GroupMembership.objects.filter(user=user, group=group).delete()
		return redirect('group_view',pk=gid)
	return render(request, 'groupview.html')

def group_article_create(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			status = request.POST['status']
			gid = request.POST['gid']
			group = Group.objects.get(pk=gid)
			if status=='1':
				article = create_article(request)
				obj = GroupArticles.objects.create(article=article, user=request.user, group=group)
				return redirect('article_view', article.pk)
			else:
				return render(request, 'new_article.html', {'group':group, 'status':1})
		else:
			return redirect('home')
	else:
		return redirect('login')
