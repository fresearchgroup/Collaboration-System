from django.shortcuts import render, redirect
from BasicArticle.views import create_article, view_article, getHTML

# Create your views here.
from django.http import Http404, HttpResponse, JsonResponse
from django.shortcuts import render
from BasicArticle.models import Articles
from .models import Community, CommunityMembership, CommunityArticles, RequestCommunityCreation, CommunityGroups, CommunityCourses, CommunityMedia
from rest_framework import viewsets
from .models import CommunityGroups
from django.contrib.auth.models import Group as Roles
from UserRolesPermission.views import user_dashboard
from django.contrib.auth.models import Group as Roles
from rolepermissions.roles import assign_role
from UserRolesPermission.roles import CommunityAdmin
from django.contrib.auth.models import User
from workflow.models import States
from django.db.models import Q
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from Course.views import course_view, create_course
from notifications.signals import notify
from actstream import action
from actstream.models import Action
from actstream.models import target_stream
from django.contrib.contenttypes.models import ContentType
from feeds.views import update_role_feed,remove_or_add_user_feed
from notification.views import notify_subscribe_unsubscribe, notify_update_role, notify_remove_or_add_user
from django.conf import settings
from ast import literal_eval
import json
import requests
from etherpad.views import create_community_ether, create_article_ether_community, create_session_community
from Media.views import create_media
from metadata.views import create_metadata
from metadata.models import MediaMetadata

def display_communities(request):
	if request.method == 'POST':
		sortby = request.POST['sortby']
		if sortby == 'a_to_z':
			communities=Community.objects.filter(parent=None).order_by('name')
		if sortby == 'z_to_a':
			communities=Community.objects.filter(parent=None).order_by('-name')
		if sortby == 'oldest':
			communities=Community.objects.filter(parent=None).order_by('created_at')
		if sortby == 'latest':
			communities=Community.objects.filter(parent=None).order_by('-created_at')
	else:
		communities=Community.objects.filter(parent=None).order_by('name')
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
	groups = CommunityGroups.objects.filter(community = pk, group__visibility='1')
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
			notify_subscribe_unsubscribe(request.user,community, 'subscribe')
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
				remove_or_add_user_feed(user,community,'left')
				notify_remove_or_add_user(user, user, community, 'left')
				obj = CommunityMembership.objects.filter(user=user, community=community).delete()
				#notify_subscribe_unsubscribe(request.user, community, 'unsubscribe')
			return redirect('community_view',pk=cid)
		return render(request, 'communityview.html')
	else:
		return redirect('login')

def community_article_create_body(request, article, community):
	if request.user.is_authenticated:
		if request.method == 'POST':
			article.body = getHTML(article)
			article.save()
			data={
				'article_id':article.pk,
				'body':article.body
			}
			return JsonResponse(data)
			# return redirect('article_view', article.pk)
			# else:
			# 	article.creation_complete = True
			# 	article.save()
			# 	return render(request, 'new_article_body.html', {'article':article,'community':community, 'status':2, 'url':settings.SERVERURL, 'articleof':'community'})
		else:
			return redirect('home')
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
				CommunityArticles.objects.create(article=article, user = request.user , community =community )

				#create the ether id for artcile blonging to this community
				padid = create_article_ether_community(cid, article)

				# return community_article_create_body(request, article, community)
				data={
					'article_id':article.id,
					'community_or_group_id':community.pk,
					'user_id':request.user.id,
					'username':request.user.username,
					'url':settings.SERVERURL,
					'articleof':'community',
					'padid':padid
				}
				return JsonResponse(data)
				# return redirect('article_edit', article.pk)


			elif status == '2' or status=='3':
				pk=''
				# print(status)
				if status == '2':
					pk = request.POST.get('pk','')
					article = Articles.objects.get(pk=pk)
					return community_article_create_body(request, article, community)
				elif status == '3':
					pk = request.POST.get('pk','3')
					article= Articles.objects.get(pk=pk)
					article.title=request.POST['title']
					try:
						image = request.FILES['article_image']
					except:
						image = None
					article.image=image
					article.save()
					data={}
					return JsonResponse(data)
			else:
				#create the session for this article in ether pad
				sid = create_session_community(request, cid)
				response = render(request, 'new_article.html', {'community':community, 'status':1})
				response.set_cookie('sessionID', sid)
				return response
		else:
			return redirect('home')
	else:
		return redirect('login')

def community_group(request, pk):
	if request.user.is_authenticated:
		if request.method == 'POST':
			community = create_group(request)
			return redirect('community_view', community.pk)
		else:
			community = Community.objects.get(pk=pk)
			return render(request, 'new_community.html', {'community':community})
	else:
		return redirect('login')

def create_group(request):
	if request.method == 'POST':
		cid = request.POST['parent']
		parent = Community.objects.get(pk=cid)
		name = request.POST['name']
		desc = request.POST['desc']
		try:
			image = request.FILES['community_image']
		except:
			image = None
		user = request.user
		#visibility = request.POST['visibility']
		community = Community.objects.create(
			name = name,
			desc  = desc,
			image = image,
			created_by = user,
			parent = parent
			)
		role = Roles.objects.get(name='community_admin')
		CommunityMembership.objects.create(user=user, community=community, role=role)

		#create ether id for the group 
		try:
			create_community_ether(community)
		except:
			error = ""
		
		#notify_remove_or_add_user(request.user, user, group, 'group_created')
		#remove_or_add_user_feed(request.user, group, "group_created")
		return community

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

				#create the ether id for community
				create_community_ether(communitycreation)

				create_wiki_for_community(communitycreation)
				communityadmin = Roles.objects.get(name='community_admin')
				communitymembership = CommunityMembership.objects.create(
					user = rcommunity.requestedby,
					community = communitycreation,
					role = communityadmin
					)
				remove_or_add_user_feed(rcommunity.requestedby,communitycreation,'community_created')
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
								notify_remove_or_add_user(request.user, user, community, 'added')
								if rolename=='publisher' or rolename=='community_admin':
									remove_or_add_user_feed(user,community,'added')

							else:
								errormessage = 'user exists in community'
						if status == 'update':
							if count > 1 or count == 1 and username != request.user.username:
								try:
									update_role_feed(user,community,rolename)
									notify_update_role(request.user, user,community,rolename)
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
									remove_or_add_user_feed(user,community,'removed')
									notify_remove_or_add_user(request.user, user,community,'removed')
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
				try:
					image = request.FILES['community_image']
				except:
					image = None


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
					image = image,
					tag_line = tag_line,
					created_by = usr,
					forum_link = forum_link
					)
				communitymembership = CommunityMembership.objects.create(
					user = usr,
					community = community,
					role = role
					)
				remove_or_add_user_feed(usr,community,'community_created')
				notify_remove_or_add_user(request.user, usr,community,'community_created')

				#create the ether id for community
				try:
					create_community_ether(community)
					create_wiki_for_community(community)
				except:
					error =""

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
			carticles = CommunityArticles.objects.raw('select "article" as type, ba.id, ba.title, ba.body, ba.image, ba.views, ba.created_at, username, workflow_states.name as state from  workflow_states, auth_user au, BasicArticle_articles as ba , Community_communityarticles as ca  where au.id=ba.created_by_id and ba.state_id=workflow_states.id and  ca.article_id =ba.id and ca.community_id=%s and ba.state_id in (select id from workflow_states as w where w.name = "visible" or w.name="publishable");', [community.pk])
			ccourse = CommunityCourses.objects.raw('select "course" as type, course.id, course.title, course.body, course.image, course.created_at, username, workflow_states.name as state from workflow_states, Course_course as course, Community_communitycourses as ccourses, auth_user au where au.id=course.created_by_id and course.state_id=workflow_states.id and course.id=ccourses.course_id and ccourses.community_id=%s and course.state_id in (select id from workflow_states as w where w.name = "visible" or w.name="publishable");', [community.pk])
			cmedia = CommunityMedia.objects.raw('select "media" as type, media.id, media.title, media.mediafile as image, media.mediatype, media.created_at, username, workflow_states.name as state from workflow_states, Media_media as media, Community_communitymedia as cmedia, auth_user au where au.id=media.created_by_id and media.state_id=workflow_states.id and media.id=cmedia.media_id and cmedia.community_id=%s and media.state_id in (select id from workflow_states as w where w.name = "visible" or w.name="publishable");', [community.pk])
			ch5p = []
			print('new test')
			try:
				response = requests.get(settings.H5P_ROOT + 'h5p/h5papi/?format=json')
				json_data = json.loads(response.text)
				print(json_data)

				for obj in json_data:
					if obj['community_id'] == community.pk:
						obj['type'] = 'h5p'
						ch5p.append(obj)
			except Exception as e:
				print(e)
				print("H5P server down...Sorry!! We will be back soon")
			lstfinal = list(carticles) +  list(cmedia) + list(ccourse) + list(ch5p)

			page = request.GET.get('page', 1)
			paginator = Paginator(list(lstfinal), 5)
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
			cgarticles = CommunityGroups.objects.raw('select "article" as type, username, bs.id, bs.title, bs.body, bs.image, bs.views, bs.created_at, gg.name from auth_user au, BasicArticle_articles bs join (select * from Group_grouparticles where group_id in (select group_id from Community_communitygroups where community_id=%s)) t on bs.id=t.article_id join Group_group gg on gg.id=group_id and gg.visibility=1 where bs.state_id=2 and au.id=bs.created_by_id;', [community.pk])
			cgmedia = CommunityGroups.objects.raw('select "media" as type, username, media.id, media.title, media.mediafile as image, media.created_at, gg.name from auth_user au, Media_media as media join (select * from Group_groupmedia where group_id in (select group_id from Community_communitygroups where community_id=%s)) t on media.id=t.media_id join Group_group gg on gg.id=group_id and gg.visibility=1 where media.state_id=2 and au.id=media.created_by_id;', [community.pk])
			cgh5p = []
			try:
				response = requests.get(settings.H5P_ROOT + 'h5p/h5papi/?format=json')
				json_data = json.loads(response.text)
				print(json_data)

				from django.db import connection
				cursor = connection.cursor()
				stmt = "select group_id from Community_communitygroups where community_id=%s"
				cursor.execute(stmt, [community.pk])
				groups_in_this_community = cursor.fetchall()
				groups_in_this_community = list(sum(groups_in_this_community, ()))

				for obj in json_data:
					if obj['group_id'] in groups_in_this_community:
						cgh5p.append(obj)
			except Exception as e:
				print(e)
				print("H5P server down...Sorry!! We will be back soon")

			lstfinal = list(cgarticles) + list(cgmedia) + list(cgh5p)
			page = request.GET.get('page', 1)
			paginator = Paginator(list(lstfinal), 5)
			try:
				commgrparticles = paginator.page(page)
			except PageNotAnInteger:
				commgrparticles = paginator.page(1)
			except EmptyPage:
				commgrparticles = paginator.page(paginator.num_pages)

	except CommunityMembership.DoesNotExist:
		return redirect('community_view', community.pk)
	return render(request, 'communitygroupcontent.html', {'community': community, 'membership':membership, 'commgrparticles':commgrparticles})



def h5p_view(request, pk):
	try:
		requests.get(settings.H5P_ROOT + 'h5p/h5papi/?format=json')
		return redirect( settings.H5P_ROOT + "h5p/content/?contentId=%s" % pk)
	except ConnectionError:
		return render(request, 'h5pserverdown', {})

def community_course_create(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			status = request.POST['status']
			cid = request.POST['cid']
			community = Community.objects.get(pk=cid)
			if status=='1':
				course = create_course(request)
				obj = CommunityCourses.objects.create(course=course, user=request.user, community=community)
				return redirect('course_view', course.pk)
			else:
				return render(request, 'new_course.html', {'community':community, 'status':1})
		else:
			return redirect('home')
	else:
		return redirect('login')



def feed_content(request, pk):
	communityfeed = ''
	try:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user=uid, community=community.pk)
		if membership:
			feeds = community.target_actions.all()
			page = request.GET.get('page', 1)
			paginator = Paginator(feeds, 10)
			try:
				communityfeed = paginator.page(page)
			except PageNotAnInteger:
				communityfeed = paginator.page(1)
			except EmptyPage:
				communityfeed = paginator.page(paginator.num_pages)

	except CommunityMembership.DoesNotExist:
		return redirect('community_view', community.pk)

	return render(request, 'communityfeed.html', {'community': community, 'membership':membership, 'feeds':communityfeed})

def community_h5p_create(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			cid = request.POST['cid']
			request.session['cid'] = cid
			request.session['gid'] = 0
			try:
				requests.get(settings.H5P_ROOT + 'h5p/h5papi/?format=json')
				return redirect(settings.H5P_ROOT + 'h5p/create/')
			except Exception as e:
				print(e)
				return render(request, 'h5pserverdown.html', {})
		return redirect('home')
	return redirect('login')

def create_wiki_for_community(community):

	from django.db import connection
	cursor = connection.cursor()
	wiki_slug = str(community.name) + str(community.pk)
	#Create wiki for this community
	cursor.execute('''SET FOREIGN_KEY_CHECKS=0''')
	insert_stmt_urlpath = (
			"INSERT INTO wiki_urlpath (id, slug, lft, rght, tree_id, level, article_id, parent_id, site_id)"
			"VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
		)

	cursor.execute(''' select rght from wiki_urlpath order by rght DESC limit 1''')
	url_rght = cursor.fetchone()[0]

	cursor.execute(''' select id from wiki_urlpath order by id DESC limit 1''')
	urlpath_id = cursor.fetchone()[0] + 1

	cursor.execute(''' select id from wiki_article order by id DESC limit 1''')
	new_id = cursor.fetchone()[0] + 1

	data_urlpath = (urlpath_id, wiki_slug , url_rght, url_rght + 1, 1, 1, new_id, 1, 1)

	cursor.execute('''update wiki_urlpath set rght = rght + 2 where slug IS NULL''')

	cursor.execute(insert_stmt_urlpath, data_urlpath)

	cursor.execute(''' select id from wiki_articlerevision order by id DESC limit 1''')
	cur_rev_id =  cursor.fetchone()[0] + 1

	insert_stmt_article = (
					"INSERT INTO wiki_article (id, created, modified, group_read, group_write, other_read, other_write,current_revision_id, group_id, owner_id)"
					"VALUES (%s, NOW(), NOW(), %s, %s, %s, %s, %s, %s, %s)"
				)

	data_article = (new_id, 1, 1, 1, 1, cur_rev_id, 1,2)
	cursor.execute(insert_stmt_article, data_article)

	cursor.execute(''' select content_type_id from wiki_articleforobject order by content_type_id DESC limit 1''')
	con_type_id = cursor.fetchone()[0]

	cursor.execute(''' select id from wiki_articleforobject order by id DESC limit 1''')
	forobject_id = cursor.fetchone()[0] + 1

	insert_stmt_articleforobject = (
					"INSERT INTO wiki_articleforobject (id, object_id, is_mptt, article_id, content_type_id)"
					"VALUES (%s, %s, %s, %s, %s)"
				)

	data_articleforobject = (forobject_id, new_id, 1, new_id, con_type_id)

	cursor.execute(insert_stmt_articleforobject, data_articleforobject)

	cursor.execute(''' select id from wiki_articlerevision order by id DESC limit 1''')
	articlerev_id = cursor.fetchone()[0] + 1

	insert_stmt_wikiarticlerevision = (
					"INSERT INTO wiki_articlerevision (id, revision_number, user_message, automatic_log, ip_address, modified, created, deleted, locked, content, title, article_id, user_id)"
					"VALUES (%s, %s, %s, %s, %s, NOW(), NOW(), %s, %s, %s, %s, %s, %s)"
				)

	data_wikiarticlerevision = (articlerev_id ,1, "Write your summary here.", "", "", 0, 0, "Write your content here", str(community.name) , new_id, 2)


	cursor.execute(insert_stmt_wikiarticlerevision, data_wikiarticlerevision)


	cursor.execute('''SET FOREIGN_KEY_CHECKS=1''')

def community_media_create(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			status = request.POST['status']
			cid = request.POST['cid']
			community = Community.objects.get(pk=cid)
			if status=='1':
				media = create_media(request)
				metadata = create_metadata(request)
				CommunityMedia.objects.create(media=media, user=request.user, community=community)
				MediaMetadata.objects.create(media=media, metadata=metadata)
				return redirect('media_view', media.pk)
			else:
				return render(request, 'new_media.html', {'community':community, 'status':1})
		else:
			return redirect('home')
	else:
		return redirect('login')
		