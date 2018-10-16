import string
from django.contrib.auth.models import User
from django.utils.crypto import get_random_string
from CollaborationSystem.settings import MEDIA_ROOT
import json
from celery import shared_task
from django.db import connection
from django.contrib.auth.models import Group as Roles
from Community.views import create_wiki_for_community
from Community.models import Community, CommunityMembership
from py_etherpad import EtherpadLiteClient
from django.conf import settings
from etherpad.models import EtherCommunity

@shared_task
def createbulkcommunity(task):
	path = task.tfile.path
	f = open(path,'r', encoding='utf-8')
	data = json.load(f)
	f.close()
	communityadmin = Roles.objects.get(name='community_admin')
	epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
	for i in data:
		name = i['name']
		desc = i['desc']
		category = i['category']
		tag_line = i['tag_line']
		admin = i['admin']

		admin = User.objects.get(username=admin)
		
		# Create Forum for this community
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
		cursor.execute(insert_stmt, data)
		cursor.execute(''' select id from forum_forum order by id desc limit 1''')
		forum_link = slug + '-' + str(cursor.fetchone()[0])

		#create the community
		community = Community.objects.create(
					name=name,
					desc=desc,
					category = category,
					tag_line = tag_line,
					created_by = admin,
					forum_link = forum_link
					)
		create_wiki_for_community(community)
		CommunityMembership.objects.create(
					user = admin,
					community = community,
					role = communityadmin
					)
		result =  epclient.createGroupIfNotExistsFor(community.id)
		EtherCommunity.objects.create(community=community, community_ether_id=result['groupID'])
	return 'Task completed with success!'