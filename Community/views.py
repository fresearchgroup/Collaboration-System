from django.shortcuts import render, redirect
from BasicArticle.views import create_article, view_article
# Create your views here.
from django.http import Http404, HttpResponse
from django.shortcuts import render
from BasicArticle.models import Articles
from .models import Community, CommunityMembership, CommunityArticles, RequestCommunityCreation, CommunityGroups
from rest_framework import viewsets
from .models import CommunityGroups
from Group.views import create_group
from django.contrib.auth.models import Group as Roles
from UserRolesPermission.views import user_dashboard
from django.contrib.auth.models import Group as Roles
from rolepermissions.roles import assign_role
from UserRolesPermission.roles import CommunityAdmin
from django.contrib.auth.models import User
from workflow.models import States
from django.db.models import Q
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
# Create your views here.


def display_communities(request):
	if request.method == 'POST':
		sortby = request.POST['sortby']
		if sortby == 'a_to_z':
			communities=Community.objects.all().order_by('name')
		if sortby == 'z_to_a':
			communities=Community.objects.all().order_by('-name')
		if sortby == 'oldest':
			communities=Community.objects.all().order_by('created_at')
		if sortby == 'latest':
			communities=Community.objects.all().order_by('-created_at')
	else:
		communities=Community.objects.all().order_by('name')
	return render(request, 'communities.html',{'communities':communities})

def community_view(request, pk):
	try:
		message = 0
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user =uid, community = community.pk)
		role = Roles.objects.get(name='community_admin')
		if membership.role == role:
			count = CommunityMembership.objects.filter(community=community,role=role).count()
			if count < 2:
				message = 1
	except CommunityMembership.DoesNotExist:
		membership = 'FALSE'
	subscribers = CommunityMembership.objects.filter(community = pk).count()
	pubarticles = CommunityArticles.objects.raw('select ba.id, ba.body, ba.title, workflow_states.name as state from  workflow_states, BasicArticle_articles as ba , Community_communityarticles as ca  where ba.state_id=workflow_states.id and  ca.article_id =ba.id and ca.community_id=%s and ba.state_id in (select id from workflow_states as w where w.name = "publish");', [community.pk])
	pubarticlescount = len(list(pubarticles))
	users = CommunityArticles.objects.raw('select  u.id,username from auth_user u join Community_communityarticles c on u.id = c.user_id where c.community_id=%s group by u.id order by count(*) desc limit 2;', [pk])
	groups = CommunityGroups.objects.filter(community = pk)
	groupcount = groups.count()
	communitymem=CommunityMembership.objects.filter(community = pk).order_by('?')[:10]
	return render(request, 'communityview.html', {'community': community, 'membership':membership, 'subscribers':subscribers, 'groups':groups, 'users':users, 'groupcount':groupcount, 'pubarticlescount':pubarticlescount, 'message':message, 'pubarticles':pubarticles, 'communitymem':communitymem})

def community_subscribe(request):
	cid = request.POST['cid']
	if request.user.is_authenticated:
		if request.method == 'POST':
			community=Community.objects.get(pk=cid)
			role = Roles.objects.get(name='author')
			user = request.user
			if CommunityMembership.objects.filter(user=user, community=community).exists():
				return redirect('community_view',pk=cid)
			obj = CommunityMembership.objects.create(user=user, community=community, role=role)
			return redirect('community_view',pk=cid)
		return render(request, 'communityview.html')
	else:
		return redirect('/login/?next=/community-view/%d' % int(cid) )

def community_unsubscribe(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			cid = request.POST['cid']
			community=Community.objects.get(pk=cid)
			user = request.user
			if CommunityMembership.objects.filter(user=user, community=community).exists():
				obj = CommunityMembership.objects.filter(user=user, community=community).delete()
			return redirect('community_view',pk=cid)
		return render(request, 'communityview.html')
	else:
		return redirect('login')

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
			if status=='approve' and rcommunity.status!='approved':

				# Create Forum for this community
				from django.db import connection
				cursor = connection.cursor()
				cursor.execute(''' select tree_id from forum_forum order by tree_id DESC limit 1''')
				tree_id = cursor.fetchone()[0] + 1
				slug = "-".join(rcommunity.name.lower().split())
				#return HttpResponse(str(tree_id))
				insert_stmt = (
					  "INSERT INTO forum_forum (created,updated,name,slug,description,link_redirects,type,link_redirects_count,display_sub_forum_list,lft,rght,tree_id,level,direct_posts_count,direct_topics_count) "
					  "VALUES (NOW(), NOW(), %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
					)
				data = (rcommunity.name, slug, rcommunity.desc, 0,0,0,1,1,2,tree_id,0,0,0)
				try:
					cursor.execute(insert_stmt, data)
					cursor.execute(''' select id from forum_forum order by id desc limit 1''')
					forum_link = slug + '-' + str(cursor.fetchone()[0])
				except:
					errormessage = 'Can not create default forum for this community'
					return render(request, 'new_community.html', {'errormessage':errormessage})

				communitycreation = Community.objects.create(
					name = rcommunity.name,
					desc = rcommunity.desc,
					tag_line = rcommunity.tag_line,
					category = rcommunity.category,
					created_by = rcommunity.requestedby,
					forum_link = forum_link

					)
				communityadmin = Roles.objects.get(name='community_admin')
				communitymembership = CommunityMembership.objects.create(
					user = rcommunity.requestedby,
					community = communitycreation,
					role = communityadmin
					)
				rcommunity.status = 'approved'
				rcommunity.save()

			if status=='reject' and rcommunity.status!='rejected':
				rcommunity.status = 'rejected'
				rcommunity.save()


		requestcommunitycreation=RequestCommunityCreation.objects.filter(status='Request')
		return render(request, 'community_creation_requests.html',{'requestcommunitycreation':requestcommunitycreation})
	else:
		return redirect('login')

def manage_community(request,pk):
	if request.user.is_authenticated:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		errormessage = ''
		membership = None
		try:
			membership = CommunityMembership.objects.get(user =uid, community = community.pk)
			if membership.role.name == 'community_admin':
				count = CommunityMembership.objects.filter(community = community.pk, role=membership.role).count()
				members = CommunityMembership.objects.filter(community = community.pk)
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
							else:
								errormessage = 'cannot update this user'
						if status == 'remove':
							if count > 1 or count == 1 and username != request.user.username:
								try:
									obj = CommunityMembership.objects.filter(user=user, community=community).delete()
								except CommunityMembership.DoesNotExist:
									errormessage = 'no such user in the community'
							else:
								errormessage = 'cannot remove this user'
						return render(request, 'managecommunity.html', {'community': community, 'members':members,'membership':membership, 'errormessage':errormessage})
	#					return redirect('manage_community',pk=pk)
					except User.DoesNotExist:
						errormessage = "no such user in the system"

				return render(request, 'managecommunity.html', {'community': community, 'members':members,'membership':membership, 'errormessage':errormessage})
			else:
				return redirect('community_view',pk=pk)
		except CommunityMembership.DoesNotExist:
			return redirect('community_view',pk=pk)
	else:
		return redirect('login')

def update_community_info(request,pk):
	if request.user.is_authenticated:
		community = Community.objects.get(pk=pk)
		errormessage = ''
		membership = None
		uid = request.user.id
		try:
			membership = CommunityMembership.objects.get(user=uid, community=community.pk)
			if membership.role.name == 'community_admin':
				if request.method == 'POST':
					desc = request.POST['desc']
					category = request.POST['category']
					tag_line = request.POST['tag_line']
					community.desc = desc
					community.category = category
					community.tag_line = tag_line
					try:
						image = request.FILES['community_image']
						community.image = image
					except:
						errormessage = 'image not uploaded'
					community.save()
					return redirect('community_view',pk=pk)
				else:
					return render(request, 'updatecommunityinfo.html', {'community':community, 'membership':membership})
			else:
				return redirect('community_view',pk=pk)
		except CommunityMembership.DoesNotExist:
			return redirect('community_view',pk=pk)
	else:
		return redirect('login')

def create_community(request):
	errormessage = ''
	if request.user.is_superuser:
		if request.method == 'POST':
			username = request.POST['username']
			try:
				usr = User.objects.get(username=username)
				name = request.POST['name']
				desc = request.POST['desc']
				category = request.POST['category']
				tag_line = request.POST['tag_line']
				role = Roles.objects.get(name='community_admin')

				# Create Forum for this community
				from django.db import connection
				cursor = connection.cursor()
				cursor.execute(''' select tree_id from forum_forum order by tree_id DESC limit 1''')
				tree_id = cursor.fetchone()[0] + 1
				slug = "-".join(name.lower().split())
				#return HttpResponse(str(tree_id))
				insert_stmt = (
					  "INSERT INTO forum_forum (created,updated,name,slug,description,link_redirects,type,link_redirects_count,display_sub_forum_list,lft,rght,tree_id,level,direct_posts_count,direct_topics_count) "
					  "VALUES (NOW(), NOW(), %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
					)
				data = (name, slug, desc, 0,0,0,1,1,2,tree_id,0,0,0)
				try:
					cursor.execute(insert_stmt, data)
					cursor.execute(''' select id from forum_forum order by id desc limit 1''')
					forum_link = slug + '-' + str(cursor.fetchone()[0])
				except:
					errormessage = 'Can not create default forum for this community'
					return render(request, 'new_community.html', {'errormessage':errormessage})


				community = Community.objects.create(
					name=name,
					desc=desc,
					category = category,
					image = request.FILES['community_image'],
					tag_line = tag_line,
					created_by = usr,
					forum_link = forum_link
					)
				communitymembership = CommunityMembership.objects.create(
					user = usr,
					community = community,
					role = role
					)


				return redirect('community_view', community.pk)
			except User.DoesNotExist:
				errormessage = 'user does not exist'
				return render(request, 'new_community.html', {'errormessage':errormessage})
		else:
			return render(request, 'new_community.html')
	else:
		return redirect('home')

def community_content(request, pk):
	commarticles = ''
	try:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user=uid, community=community.pk)
		if membership:
			carticles = CommunityArticles.objects.raw('select ba.id, ba.title, ba.body, ba.image, ba.views, ba.created_at, username, workflow_states.name as state from  workflow_states, auth_user au, BasicArticle_articles as ba , Community_communityarticles as ca  where au.id=ba.created_by_id and ba.state_id=workflow_states.id and  ca.article_id =ba.id and ca.community_id=%s and ba.state_id in (select id from workflow_states as w where w.name = "visible" or w.name="publishable");', [community.pk])

			page = request.GET.get('page', 1)
			paginator = Paginator(list(carticles), 5)
			try:
				commarticles = paginator.page(page)
			except PageNotAnInteger:
				commarticles = paginator.page(1)
			except EmptyPage:
				commarticles = paginator.page(paginator.num_pages)

	except CommunityMembership.DoesNotExist:
		return redirect('community_view', community.pk)
	return render(request, 'communitycontent.html', {'community': community, 'membership':membership, 'commarticles':commarticles})

def community_group_content(request, pk):
	commgrparticles = ''
	try:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user=uid, community=community.pk)
		if membership:
			cgarticles = CommunityGroups.objects.raw('select username, bs.id, bs.title, bs.body, bs.image, bs.views, bs.created_at, gg.name from auth_user au, BasicArticle_articles bs join (select * from Group_grouparticles where group_id in (select group_id from Community_communitygroups where community_id=%s)) t on bs.id=t.article_id join Group_group gg on gg.id=group_id where bs.state_id=2 and au.id=bs.created_by_id;', [community.pk])
			page = request.GET.get('page', 1)
			paginator = Paginator(list(cgarticles), 5)
			try:
				commgrparticles = paginator.page(page)
			except PageNotAnInteger:
				commgrparticles = paginator.page(1)
			except EmptyPage:
				commgrparticles = paginator.page(paginator.num_pages)

	except CommunityMembership.DoesNotExist:
		return redirect('community_view', community.pk)
	return render(request, 'communitygroupcontent.html', {'community': community, 'membership':membership, 'commgrparticles':commgrparticles})
