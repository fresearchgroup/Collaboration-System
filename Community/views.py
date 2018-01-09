from django.shortcuts import render, redirect
from BasicArticle.views import create_article, view_article
# Create your views here.
from django.http import Http404, HttpResponse
from django.shortcuts import render
from BasicArticle.models import Articles
from .models import Community, CommunityMembership, CommunityArticles, RequestCommunityCreation
from rest_framework import viewsets
from .models import CommunityGroups
from Group.views import create_group
from django.contrib.auth.models import Group as Roles
from UserRolesPermission.views import user_dashboard
from django.contrib.auth.models import Group as Roles
from rolepermissions.roles import assign_role
from UserRolesPermission.roles import CommunityAdmin
from django.contrib.auth.models import User

# Create your views here.


def display_communities(request):
	communities=Community.objects.all()
	return render(request, 'communities.html',{'communities':communities})

def community_view(request, pk):
	try:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user =uid, community = community.pk)
	except CommunityMembership.DoesNotExist:
		membership = 'FALSE'
	subscribers = CommunityMembership.objects.filter(community = pk).count()
	articles = CommunityArticles.objects.filter(community = pk)
	users = CommunityArticles.objects.raw('select  u.id,username from auth_user u join Community_communityarticles c on u.id = c.user_id where c.community_id=%s group by u.id order by count(*) desc limit 2;', [pk])
	groups = CommunityGroups.objects.filter(community = pk)
	groupcount = groups.count()
	articlecount = articles.count()
	return render(request, 'communityview.html', {'community': community, 'membership':membership, 'subscribers':subscribers, 'articles':articles, 'groups':groups, 'users':users, 'groupcount':groupcount, 'articlecount':articlecount})

def community_subscribe(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			cid = request.POST['cid']
			community=Community.objects.get(pk=cid)
			role = Roles.objects.get(name='author')
			user = request.user
			obj = CommunityMembership.objects.create(user=user, community=community, role=role)
			return redirect('community_view',pk=cid)
		return render(request, 'communityview.html')
	else:
		return redirect('login')

def community_unsubscribe(request):
	if request.method == 'POST':
		cid = request.POST['cid']
		community=Community.objects.get(pk=cid)
		user = request.user
		obj = CommunityMembership.objects.filter(user=user, community=community).delete()
		return redirect('community_view',pk=cid)
	return render(request, 'communityview.html')


def community_article_create(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			status = request.POST['status']
			cid = request.POST['cid']
			community = Community.objects.get(pk=cid)
			if status=='1':
				article = create_article(request)
				obj = CommunityArticles.objects.create(article=article, user = request.user , community =community )
				return redirect('article_view', article.pk)
			else:
				return render(request, 'new_article.html', {'community':community, 'status':1})
		else:
			return redirect('home')
	else:
		return redirect('login')


def community_group(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			status = request.POST['status']
			cid = request.POST['cid']
			community = Community.objects.get(pk=cid)
			if status=='1':
				group = create_group(request)
				obj = CommunityGroups.objects.create(group=group, user=request.user, community=community)
				return redirect('group_view', group.pk)
			else:
				return render(request, 'new_group.html', {'community':community, 'status':1})
		else:
			return redirect('home')
	else:
		return redirect('login')

def request_community_creation(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			name = request.POST['name']
			desc = request.POST['desc']
			category = request.POST['category']
			tag_line = request.POST['tag_line']
			purpose = request.POST['purpose']
			status = request.POST['status']
			requestcommunitycreation = RequestCommunityCreation.objects.create(
				name = name,
				desc  = desc,
				category = category,
				tag_line = tag_line,
				purpose = purpose,
				requestedby = request.user,
				email = request.user.email,
				status = status
				)
			return redirect('user_dashboard')
		else:
			return render(request, 'request_community_creation.html')
	else:
		return redirect('login')


def handle_community_creation_requests(request):

	if request.user.is_superuser:
		if request.method == 'POST':
			pk = request.POST['pk']
			rcommunity=RequestCommunityCreation.objects.get(pk=pk)
			user=rcommunity.requestedby
			status = request.POST['status']
			if status=='approve':
				communitycreation = Community.objects.create(
					name = rcommunity.name,
					desc = rcommunity.desc,
					tag_line = rcommunity.tag_line,
					category = rcommunity.category
					)
				communityadmin = Roles.objects.get(name='community_admin')
				communitymembership = CommunityMembership.objects.create(
					user = rcommunity.requestedby,
					community = communitycreation,
					role = communityadmin
					)
				rcommunity.status = 'approved'
				rcommunity.save()

			if status=='reject':
				rcommunity.status = 'rejected'
				rcommunity.save()


		requestcommunitycreation=RequestCommunityCreation.objects.filter(status='Request')
		return render(request, 'community_creation_requests.html',{'requestcommunitycreation':requestcommunitycreation})

def manage_community(request,pk):
	community = Community.objects.get(pk=pk)
	uid = request.user.id
	errormessage = ''
	membership = None
	try:
		membership = CommunityMembership.objects.get(user =uid, community = community.pk)
		if membership.role.name == 'community_admin':
			count = CommunityMembership.objects.filter(community = community.pk, role=membership.role).count()
			if request.method == 'POST':
				try:
					username = request.POST['username']
					rolename = request.POST['role']
					user = User.objects.get(username = username)
					role = Roles.objects.get(name=rolename)
					status = request.POST['status']

					if status == 'add':
						try:
							is_member = CommunityMembership.objects.get(user =user, community = community.pk)
						except CommunityMembership.DoesNotExist:
							obj = CommunityMembership.objects.create(user=user, community=community, role=role)
						else:
							errormessage = 'user exists in community'
					if status == 'update':
						if count > 1 or count == 1 and username != request.user.username:
							try:
								is_member = CommunityMembership.objects.get(user =user, community = community.pk)
								is_member.role = role
								is_member.save()
							except CommunityMembership.DoesNotExist:
								errormessage = 'no such user in the community'
					if status == 'remove':
						if count > 1 or count == 1 and username != request.user.username:
							try:
								obj = CommunityMembership.objects.filter(user=user, community=community).delete()
							except CommunityMembership.DoesNotExist:
								errormessage = 'no such user in the community'
					return redirect('manage_community',pk=pk)
				except User.DoesNotExist:
					errormessage = "no such user in the community"
			members = CommunityMembership.objects.filter(community = community.pk)
			return render(request, 'managecommunity.html', {'community': community, 'members':members,'membership':membership, 'errormessage':errormessage})
		else:
			return redirect('community_view',pk=pk)
	except CommunityMembership.DoesNotExist:
		return redirect('community_view',pk=pk)

def update_community_info(request,pk):
	community = Community.objects.get(pk=pk)
	errormessage = ''
	membership = None
	uid = request.user.id
	try:
		membership = CommunityMembership.objects.get(user=uid, community=community.pk)
		if membership.role.name == 'community_admin':
			if request.method == 'POST':
				name = request.POST['name']
				desc = request.POST['desc']
				category = request.POST['category']
				tag_line = request.POST['tag_line']
				community.name = name
				community.desc = desc
				community.category = category
				community.tag_line = tag_line
				community.save()
				return redirect('community_view',pk=pk)
			else:
				return render(request, 'updatecommunityinfo.html', {'community':community})
		else:
			return redirect('community_view',pk=pk)
	except CommunityMembership.DoesNotExist:
		return redirect('community_view',pk=pk)
