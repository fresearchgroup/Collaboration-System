from django.db import connection
from Community.models import Community, CommunityMembership, CommunityMedia, CommunityArticles, CommunityGroups
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles
from BasicArticle.models import Articles
from workflow.models import States
from Media.models import Media
from Categories.models import Category
from Community.views import create_wiki_for_community
from metadata.models import Metadata, MediaMetadata

def migrate_communities():
	cursor=connection.cursor()
	cursor.execute('INSERT INTO temple_migration.auth_user SELECT * from temples.auth_user;')
	cursor.execute('select * from temples.Community_community;')
	community = dictfetchall(cursor)

	for i in community:
		user = User.objects.get(pk=i['created_by_id'])
		forum_link, fid = Community.create_forum(i['name'], i['desc'])
		com = Community.objects.create(name=i['name'], desc=i['desc'], tag_line=i['tag_line'], created_by=user ,image=i['image'], forum_link=forum_link, forum=fid, image_thumbnail=i['image_thumbnail'])
		create_wiki_for_community(com)
		cursor.execute("select role_id from temples.Community_communitymembership where community_id=%s and user_id=%s;",[i['id'], i['created_by_id']])
		membership = dictfetchall(cursor)
		role = Roles.objects.get(pk=membership[0]['role_id'])
		CommunityMembership.objects.create(user=user, community=com, role=role)

		cursor.execute("select * from temples.Community_communityarticles where community_id=%s;", [i['id']])
		articles = dictfetchall(cursor)

		if articles:
			for a in articles:
				cursor.execute("select * from temples.BasicArticle_articles where id=%s;",[a['article_id']])
				a = dictfetchall(cursor)
				state = States.objects.get(pk=a[0]['state_id'])
				if state == State.objects.get(name='private'):
					state = State.objects.get(name='visible')
				user = User.objects.get(pk=a[0]['created_by_id'])
				a=Articles.objects.create(title=a[0]['title'], body=a[0]['body'], image=a[0]['image'], created_by=user, state=state )
				CommunityArticles.objects.create(article=a, user=user, community=com)

		cursor.execute("select * from temples.Community_communitymedia where community_id=%s;", [i['id']])
		medias = dictfetchall(cursor)

		if medias:
			for m in medias:
				cursor.execute("select * from temples.Media_media where id=%s;",[m['media_id']])
				m = dictfetchall(cursor)
				state = States.objects.get(pk=m[0]['state_id'])
				user = User.objects.get(pk=m[0]['created_by_id'])
				cursor.execute("select * from temples.metadata_mediametadata where media_id=%s;",[m[0]['id']])
				ma = dictfetchall(cursor)
				cursor.execute("select * from temples.metadata_metadata where id=%s;",[ma[0]['metadata_id']])
				ma = dictfetchall(cursor)
				ma=Metadata.objects.create(description=ma[0]['description'])
				m=Media.objects.create(mediatype=m[0]['mediatype'], title=m[0]['title'], mediafile=m[0]['mediafile'], created_by=user, state=state, medialink=m[0]['medialink'] )
				CommunityMedia.objects.create(media=m, user=user, community=com)
				MediaMetadata.objects.create(media=m, metadata=ma)

		cursor.execute("select * from temples.Community_communitygroups where community_id=%s;", [i['id']])
		groups = dictfetchall(cursor)

		if groups:
			for g in groups:
				cursor.execute("select * from temples.Group_group where id=%s;",[g['group_id']])
				g = dictfetchall(cursor)
				user = User.objects.get(pk=g[0]['created_by_id'])

				cursor.execute("select category_id from temples.Category_groupcategory where group_id=%s;",[g[0]['id']])
				cat = dictfetchall(cursor)
				cursor.execute("select * from temples.Category_category where id=%s;",[cat[0]['category_id']])
				cat = dictfetchall(cursor)
				if not Category.objects.filter(name=cat[0]['name']).exists():
					cat= Category.objects.create(name=cat[0]['name'], image=cat[0]['image'])
				else:
					cat= Category.objects.get(name=cat[0]['name'])

				grp = Community.objects.create(name=g[0]['name'], desc=g[0]['desc'], image=g[0]['image'], category=cat, created_by=user, parent=com)

				cursor.execute("select role_id from temples.Group_groupmembership where group_id=%s and user_id=%s;",[g[0]['id'], g[0]['created_by_id']])
				membership = dictfetchall(cursor)
				role = Roles.objects.get(pk=membership[0]['role_id'])
				if role == Roles.objects.get(name='group_admin'):
					role = Roles.objects.get(name='community_admin')
				CommunityMembership.objects.create(user=user, community=grp, role=role)

				cursor.execute("select * from temples.Group_grouparticles where group_id=%s;", [g[0]['id']])
				articles = dictfetchall(cursor)

				if articles:
					for a in articles:
						cursor.execute("select * from temples.BasicArticle_articles where id=%s;",[a['article_id']])
						a = dictfetchall(cursor)
						state = States.objects.get(pk=a[0]['state_id'])
						if state == State.objects.get(name='private'):
							state = State.objects.get(name='visible')
						user = User.objects.get(pk=a[0]['created_by_id'])
						a=Articles.objects.create(title=a[0]['title'], body=a[0]['body'], image=a[0]['image'], created_by=user, state=state )
						CommunityArticles.objects.create(article=a, user=user, community=grp)

				cursor.execute("select * from temples.Group_groupmedia where group_id=%s;", [g[0]['id']])
				medias = dictfetchall(cursor)

				if medias:
					for m in medias:
						cursor.execute("select * from temples.Media_media where id=%s;",[m['media_id']])
						m = dictfetchall(cursor)
						state = States.objects.get(pk=m[0]['state_id'])
						user = User.objects.get(pk=m[0]['created_by_id'])
						cursor.execute("select * from temples.metadata_mediametadata where media_id=%s;",[m[0]['id']])
						ma = dictfetchall(cursor)
						cursor.execute("select * from temples.metadata_metadata where id=%s;",[ma[0]['metadata_id']])
						ma = dictfetchall(cursor)
						ma=Metadata.objects.create(description=ma[0]['description'])
						m=Media.objects.create(mediatype=m[0]['mediatype'], title=m[0]['title'], mediafile=m[0]['mediafile'], created_by=user, state=state, medialink=m[0]['medialink'] )
						CommunityMedia.objects.create(media=m, user=user, community=grp)
						MediaMetadata.objects.create(media=m, metadata=ma)



def dictfetchall(cursor):
    "Return all rows from a cursor as a dict"
    columns = [col[0] for col in cursor.description]
    return [
        dict(zip(columns, row))
        for row in cursor.fetchall()
    ]