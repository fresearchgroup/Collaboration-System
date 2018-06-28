# from django.core.urlresolvers import reverse
# from django.urls import resolve
# from django.test import TestCase,TransactionTestCase
# from django.contrib.auth.models import User
# from . import views
# from Community.models import Community, CommunityArticles, CommunityMembership, CommunityGroups
# from Group.models import Group, GroupArticles, GroupMembership
# from BasicArticle.models import Articles
# from django.contrib.auth.models import Group as Roles
# from workflow.models import States
# from voting.models import ArticleVotes,VotingFlag,ArticleReport,Badges
# from voting.views import updown,article_report
# from .models import CommunityRep,SystemRep,ReputationDashboard
# from .views import author_reputation_dashboard, general_reputation_dashboard, publisher_reputation_dashboard, communityadmin_reputation_dashboard,article_published,check_article,rolechange
# from django.test.client import RequestFactory



# class TestUpdown(TransactionTestCase):
# 	reset_sequence=True
# 	def setUp(self):
# 		self.factory = RequestFactory()

# 		self.user1 = User.objects.create(username="user1", password="pwd", email="example@example.com")
# 		self.user2 = User.objects.create(username="user2", password="pwd", email="example@example.com")
# 		self.user3 = User.objects.create(username="user3", password="pwd", email="example@example.com")
# 		self.comm = Community.objects.create(name='fake_community', desc='fake',image='/home/karthik/Downloads/index.jpg',category='fake', created_by=self.user1, tag_line='always fake',forum_link='jvajds')

# 		self.grp = Group.objects.create(name='fake_grp', desc='I am fake', image='/home/karthik/Downloads/index.jpg',visibility=True, created_by=self.user1)

# 		self.author_role = Roles.objects.create(name='author')
# 		self.publisher_role = Roles.objects.create(name='publisher')
# 		self.comm_admin = Roles.objects.create(name='community_admin')
# 		self.grp_admin = Roles.objects.create(name='group_admin')

# 		self.c_author = CommunityMembership.objects.create(user=self.user1, community=self.comm, role=self.author_role)
# 		self.c_publisher = CommunityMembership.objects.create(user=self.user2, community=self.comm,role=self.publisher_role)
# 		self.community_admin = CommunityMembership.objects.create(user=self.user3, community=self.comm, role=self.comm_admin)

# 		self.g_author = GroupMembership.objects.create(user=self.user1, group=self.grp, role=self.author_role)
# 		self.g_publisher = GroupMembership.objects.create(user=self.user2, group=self.grp,role=self.publisher_role)
# 		self.group_admin = GroupMembership.objects.create(user=self.user3, group=self.grp, role=self.grp_admin)

# 		self.commgrp = CommunityGroups.objects.create(group=self.grp, user=self.user3, community=self.comm)

# 		self.draft=States.objects.create(name='draft')
# 		self.private = States.objects.create(name='private')
# 		self.visible=States.objects.create(name='visible')
# 		self.publishable=States.objects.create(name='publishable')
# 		self.publish=States.objects.create(name='publish')

# 		self.article1 = Articles.objects.create(title='fake_article1', body='abc', created_by=self.user1, state=self.draft)
# 		self.article2 = Articles.objects.create(title='fake_article2', body='xyz', created_by=self.user1, state=self.draft)

# 		self.comm_article = CommunityArticles.objects.create(article=self.article1, community=self.comm, user=self.user1)
# 		self.group_article = GroupArticles.objects.create(article=self.article2, group=self.grp, user=self.user1)

# 		self.comm_rep1 = CommunityRep.objects.create(community=self.comm,user=self.user1)
# 		self.comm_rep2 = CommunityRep.objects.create(community=self.comm,user=self.user2)
# 		self.comm_rep3 = CommunityRep.objects.create(community=self.comm,user=self.user3)

# 		self.sys_rep1 = SystemRep.objects.create(user=self.user1)
# 		self.sys_rep2 = SystemRep.objects.create(user=self.user2)
# 		self.sys_rep3 = SystemRep.objects.create(user=self.user3)

# 		self.default_val = ReputationDashboard.objects.create()

# 		self.articlevotes1 = ArticleVotes.objects.create(article=self.article1)
# 		self.articlevotes2 = ArticleVotes.objects.create(article=self.article2)

# 		self.votingflag_1_1 = VotingFlag.objects.create(article=self.article1,user=self.user1)
# 		self.votingflag_1_2 = VotingFlag.objects.create(article=self.article1,user=self.user2)
# 		self.votingflag_1_3 = VotingFlag.objects.create(article=self.article1,user=self.user3)
# 		self.votingflag_2_1 = VotingFlag.objects.create(article=self.article2,user=self.user1)
# 		self.votingflag_2_2 = VotingFlag.objects.create(article=self.article2,user=self.user2)
# 		self.votingflag_2_3 = VotingFlag.objects.create(article=self.article2,user=self.user3)

# 		self.articlereport1 = ArticleReport.objects.create(article=self.article1,community=self.comm,no_of_report=5)

# 		self.badge1 = Badges.objects.create(user=self.user1)
# 		self.badge2 = Badges.objects.create(user=self.user2)
# 		self.badge3 = Badges.objects.create(user=self.user3)


# 	def test_author_reputation_dashboard_get(self):
# 		request = initiate_get(self,'author_reputation_dashboard')
# 		response = author_reputation_dashboard(request)
# 		self.assertEqual(response.status_code,200)

# 	def test_author_reputation_dashboard_post(self):
# 		url = reverse('author_reputation_dashboard')
# 		request = self.factory.post(url,{'published_author':25,'author_report':10})
# 		response = author_reputation_dashboard(request)
# 		reputationvalue = ReputationDashboard.objects.get(pk=1)
# 		self.assertEqual(reputationvalue.published_author,25)
# 		self.assertEqual(reputationvalue.author_report,10)

# 	def test_general_reputation_dashboard_get(self):
# 		request = initiate_get(self,'general_reputation_dashboard')
# 		response = author_reputation_dashboard(request)
# 		self.assertEqual(response.status_code,200)

# 	def test_general_reputation_dashboard_post(self):
# 		url = reverse('general_reputation_dashboard')
# 		request = self.factory.post(url,{'upvote':5,'downvote':10,'min_srep_for_comm':1000,'srep_for_comm_creation':100,'threshold_publisher':3000,'threshold_cadmin':4000,'article_report_rejected':5})
# 		response = general_reputation_dashboard(request)
# 		reputationvalue = ReputationDashboard.objects.get(pk=1)
# 		#checking only few
# 		self.assertEqual(reputationvalue.upvote,5)
# 		self.assertEqual(reputationvalue.downvote,10)
# 		self.assertEqual(reputationvalue.min_srep_for_comm,1000)
# 		self.assertEqual(reputationvalue.srep_for_comm_creation,100)

# 	def test_publisher_reputation_dashboard_get(self):
# 		request = initiate_get(self,'publisher_reputation_dashboard')
# 		response = publisher_reputation_dashboard(request)
# 		self.assertEqual(response.status_code,200)

# 	def test_publisher_reputation_dashboard_post(self):
# 		url = reverse('publisher_reputation_dashboard')
# 		request = self.factory.post(url,{'published_publisher':10,'publisher_report':50})
# 		response = publisher_reputation_dashboard(request)
# 		reputationvalue = ReputationDashboard.objects.get(pk=1)
# 		self.assertEqual(reputationvalue.published_publisher,10)
# 		self.assertEqual(reputationvalue.publisher_report,50)

# 	def test_communityadmin_reputation_dashboard_get(self):
# 		request = initiate_get(self,'communityadmin_reputation_dashboard')
# 		response = communityadmin_reputation_dashboard(request)
# 		self.assertEqual(response.status_code,200)

# 	def test_publisher_reputation_dashboard_post(self):
# 		url = reverse('communityadmin_reputation_dashboard')
# 		request = self.factory.post(url,{'threshold_report':10})
# 		response = communityadmin_reputation_dashboard(request)
# 		reputationvalue = ReputationDashboard.objects.get(pk=1)
# 		self.assertEqual(reputationvalue.threshold_report,10)

# 	def test_article_published(self):
# 		article = Articles.objects.get(title='fake_article1')
# 		request = self
# 		request.user = self.user2
# 		article_published(request,article.id)
# 		comm_rep1 = CommunityRep.objects.get(community=self.comm,user=self.user1)
# 		sys_rep1 = SystemRep.objects.get(user=self.user1)
# 		comm_rep2 = CommunityRep.objects.get(community=self.comm,user=self.user2)
# 		sys_rep2 = SystemRep.objects.get(user=self.user2)
# 		self.assertEqual(comm_rep1.rep,30)
# 		self.assertEqual(comm_rep2.rep,30)
# 		self.assertEqual(sys_rep1.sysrep,30)
# 		self.assertEqual(sys_rep2.sysrep,30)

# 	def test_check_article_comm(self):
# 		article = Articles.objects.get(title='fake_article1')
# 		community = check_article(article.id)
# 		self.assertEqual(self.comm,community)

# 	def test_check_article_grp(self):
# 		article = Articles.objects.get(title='fake_article1')
# 		community = check_article(article.id)
# 		self.assertEqual(self.comm,community)

# 	def test_role_change_publisher(self):
# 		comm_rep1 = CommunityRep.objects.get(community=self.comm,user=self.user1)
# 		comm_rep1.rep = 2500
# 		comm_rep1.save()
# 		rolechange(comm_rep1,self.user1,self.comm)
# 		comm_member = CommunityMembership.objects.get(user=self.user1,community=self.comm)
# 		self.assertEqual(comm_member.role,self.publisher_role)

# 	def test_role_change_communityadmin(self):
# 		comm_rep1 = CommunityRep.objects.get(community=self.comm,user=self.user1)
# 		comm_rep1.rep = 3500
# 		comm_rep1.save()
# 		rolechange(comm_rep1,self.user1,self.comm)
# 		comm_member = CommunityMembership.objects.get(user=self.user1,community=self.comm)
# 		self.assertEqual(comm_member.role,self.comm_admin)


# def initiate_get(self,dashboard):
# 	self.user1 = User.objects.create_superuser('myuser', 'myemail@test.com', password='pwd')
# 	url = reverse(dashboard)
# 	request = self.factory.get(url)
# 	request.user = self.user1
# 	return request
