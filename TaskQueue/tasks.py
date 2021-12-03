import string
from django.contrib.auth.models import User
from django.utils.crypto import get_random_string
from CollaborationSystem.settings import MEDIA_ROOT
import json
from celery import shared_task
from django.db import connection
from django.contrib.auth.models import Group as Roles
from Community.views import create_wiki_for_community
from Community.models import Community, CommunityMembership, Locations
from py_etherpad import EtherpadLiteClient
from django.conf import settings
from etherpad.models import EtherCommunity
from .models import Task
import pandas as pd

# @shared_task
def createbulkcommunity(taskid):
	task = Task.objects.get(pk=taskid)
	path = task.tfile.path
	f = open(path,'r', encoding='utf-8')
	data = json.load(f)
	f.close()
	communityadmin = Roles.objects.get(name='community_admin')
	# epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
	for i in data:
		name = i['name']
		desc = i['desc']
		# category = i['category']
		tag_line = i['tag_line']
		area = i['area']
		city = i['city']
		district=i['district']
		state = i['state']
		pincode = i['pincode']
		admin = i['admin']
		parent = i['parent']

		admin = User.objects.get(username=admin)
		if parent == "null":
			parent = None
		else:
			parent = Community.objects.get(name=parent)
		
		# # Create Forum for this community
		# cursor = connection.cursor()
		# cursor.execute(''' select tree_id from forum_forum order by tree_id DESC limit 1''')
		# tree_id = cursor.fetchone()[0] + 1
		# slug = "-".join(name.lower().split())
		# #return HttpResponse(str(tree_id))
		# insert_stmt = (
		# 	"INSERT INTO forum_forum (created,updated,name,slug,description,link_redirects,type,link_redirects_count,display_sub_forum_list,lft,rght,tree_id,level,direct_posts_count,direct_topics_count) "
		# 	"VALUES (NOW(), NOW(), %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
		# 	)
		# data = (name, slug, desc, 0,0,0,1,1,2,tree_id,0,0,0)
		# cursor.execute(insert_stmt, data)
		# cursor.execute(''' select id from forum_forum order by id desc limit 1''')
		# forum_link = slug + '-' + str(cursor.fetchone()[0])

		#create the community
		community = Community.objects.create(
					name=name,
					desc=desc,
					# category = category,
					tag_line = tag_line,
					created_by = admin,
					area = area,
					city = city,
					district=district,
					state = state,
					pincode = pincode,
					parent = parent
					# forum_link = forum_link
					)
		# create_wiki_for_community(community)
		CommunityMembership.objects.create(
					user = admin,
					community = community,
					role = communityadmin
					)

		# create sections for each community of level 1
		if parent is None:
			pass
		else:
			Community.objects.create(name='Introduction', created_by = admin, parent = community)
			Community.objects.create(name='Architecture', created_by = admin, parent = community)
			Community.objects.create(name='Rituals', created_by = admin, parent = community)
			Community.objects.create(name='Ceremonies', created_by = admin, parent = community)
			Community.objects.create(name='Tales', created_by = admin, parent = community)
			Community.objects.create(name='More Information', created_by = admin, parent = community)

		# result =  epclient.createGroupIfNotExistsFor(community.id)
		# EtherCommunity.objects.create(community=community, community_ether_id=result['groupID'])
	task.status = True
	task.save()
	return "Task completed with success!"

def createlocations(taskid):
	task = Task.objects.get(pk=taskid)
	path = task.tfile.path
	tmp_data=pd.read_csv(path,sep=',')
	df_records = tmp_data.to_dict('records')
	locations = [
		Locations(
			pincode = record['Pincode'], 
			city = record['City'], 
			district = record['District'], 
			state = record['State'],
		)
		for record in df_records
	]
	Locations.objects.bulk_create(locations)
	task.status = True
	task.save()
	return "Task completed with success!"
