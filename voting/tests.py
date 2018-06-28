from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase,TransactionTestCase
from django.contrib.auth.models import User
from . import views
from Community.models import Community, CommunityArticles, CommunityMembership, CommunityGroups
from Group.models import Group, GroupArticles, GroupMembership
from BasicArticle.models import Articles
from django.contrib.auth.models import Group as Roles
from workflow.models import States
from .models import ArticleVotes,VotingFlag,ArticleReport
from .views import updown,article_report
from reputation.models import CommunityRep,SystemRep,ReputationDashboard
from django.test.client import RequestFactory



class TestUpdown(TransactionTestCase):
	reset_sequence=True
	def setUp(self):
		self.factory = RequestFactory()

		self.user1 = User.objects.create(username="user1", password="pwd", email="example@example.com")
		self.user2 = User.objects.create(username="user2", password="pwd", email="example@example.com")
		self.user3 = User.objects.create(username="user3", password="pwd", email="example@example.com")
		self.comm = Community.objects.create(name='fake_community', desc='fake',image='/home/karthik/Downloads/index.jpg',category='fake', created_by=self.user1, tag_line='always fake',forum_link='jvajds')

		self.grp = Group.objects.create(name='fake_grp', desc='I am fake', image='/home/karthik/Downloads/index.jpg',visibility=True, created_by=self.user1)

		self.author_role = Roles.objects.create(name='author')
		self.publisher_role = Roles.objects.create(name='publisher')
		self.comm_admin = Roles.objects.create(name='community_admin')
		self.grp_admin = Roles.objects.create(name='group_admin')

		self.c_author = CommunityMembership.objects.create(user=self.user1, community=self.comm, role=self.author_role)
		self.c_publisher = CommunityMembership.objects.create(user=self.user2, community=self.comm,role=self.publisher_role)

		self.community_admin = CommunityMembership.objects.create(user=self.user3, community=self.comm, role=self.comm_admin)

		self.g_author = GroupMembership.objects.create(user=self.user1, group=self.grp, role=self.author_role)
		self.g_publisher = GroupMembership.objects.create(user=self.user2, group=self.grp,role=self.publisher_role)

		self.group_admin = GroupMembership.objects.create(user=self.user3, group=self.grp, role=self.grp_admin)

		self.commgrp = CommunityGroups.objects.create(group=self.grp, user=self.user3, community=self.comm)

		self.draft=States.objects.create(name='draft')
		self.private = States.objects.create(name='private')
		self.visible=States.objects.create(name='visible')
		self.publishable=States.objects.create(name='publishable')
		self.publish=States.objects.create(name='publish')

		self.article1 = Articles.objects.create(title='fake_article1', body='abc', created_by=self.user1, state=self.draft)
		self.article2 = Articles.objects.create(title='fake_article2', body='xyz', created_by=self.user1, state=self.draft)

		self.comm_article = CommunityArticles.objects.create(article=self.article1, community=self.comm, user=self.user1)
		self.group_article = GroupArticles.objects.create(article=self.article2, group=self.grp, user=self.user1)

		self.comm_rep1 = CommunityRep.objects.create(community=self.comm,user=self.user1)
		self.comm_rep2 = CommunityRep.objects.create(community=self.comm,user=self.user2)
		self.comm_rep3 = CommunityRep.objects.create(community=self.comm,user=self.user3)

		self.sys_rep1 = SystemRep.objects.create(user=self.user1)
		self.sys_rep2 = SystemRep.objects.create(user=self.user2)
		self.sys_rep3 = SystemRep.objects.create(user=self.user3)

		self.default_val = ReputationDashboard.objects.create()

		self.articlevotes1 = ArticleVotes.objects.create(article=self.article1)
		self.articlevotes2 = ArticleVotes.objects.create(article=self.article2)

		self.votingflag_1_1 = VotingFlag.objects.create(article=self.article1,user=self.user1)
		self.votingflag_1_2 = VotingFlag.objects.create(article=self.article1,user=self.user2)
		self.votingflag_1_3 = VotingFlag.objects.create(article=self.article1,user=self.user3)
		self.votingflag_2_1 = VotingFlag.objects.create(article=self.article2,user=self.user1)
		self.votingflag_2_2 = VotingFlag.objects.create(article=self.article2,user=self.user2)
		self.votingflag_2_3 = VotingFlag.objects.create(article=self.article2,user=self.user3)

		self.articlereport1 = ArticleReport.objects.create(article=self.article1,community=self.comm,no_of_report=5)

	def test_updown_get(self):
		url = reverse('updown')
		response = self.client.get(url)
		self.assertEqual(response.status_code , 302) #the updown view function redirects to another page. Django redirect() always returns HTTP 302

	def test_updown_post_type1(self):
		# print(Articles.objects.all())
		request = initiate_updown(self,'upvote')
		response = updown(request)
		retrieve_updown(self)
		self.assertEqual(response.status_code , 302)
		self.assertEqual(self.articlevotes1.upvote,1)
		self.assertEqual(self.votingflag_1_2.upflag,True)
		self.assertEqual(self.comm_rep1.rep,27)
		self.assertEqual(self.sys_rep1.sysrep,27)

	def test_updown_post_type2(self):
		request = initiate_updown(self,'downvote')
		response = updown(request)
		retrieve_updown(self)
		self.assertEqual(response.status_code , 302)
		self.assertEqual(self.articlevotes1.downvote,1)
		self.assertEqual(self.votingflag_1_2.downflag,True)
		self.assertEqual(self.comm_rep1.rep,23)
		self.assertEqual(self.sys_rep1.sysrep,23)

	def test_updown_post_type6(self):
		request = initiate_updown(self,'downvote')
		article = ArticleVotes.objects.get(article=self.article1)
		article.upvote = 1
		votingflag_1_2 = VotingFlag.objects.get(article=self.article1,user=self.user2)
		votingflag_1_2.upflag =True
		article.save()
		votingflag_1_2.save()
		response = updown(request)
		retrieve_updown(self)
		self.assertEqual(response.status_code , 302)
		self.assertEqual(self.articlevotes1.downvote,1)
		self.assertEqual(self.articlevotes1.upvote,0)
		self.assertEqual(self.votingflag_1_2.downflag,True)
		self.assertEqual(self.votingflag_1_2.upflag,False)
		self.assertEqual(self.comm_rep1.rep,21)
		self.assertEqual(self.sys_rep1.sysrep,21)	

	def test_updown_post_type5(self):
		request = initiate_updown(self,'upvote')
		article = ArticleVotes.objects.get(article=self.article1)
		article.downvote = 1
		votingflag_1_2 = VotingFlag.objects.get(article=self.article1,user=self.user2)
		votingflag_1_2.downflag =True
		article.save()
		votingflag_1_2.save()
		response = updown(request)
		retrieve_updown(self)
		self.assertEqual(response.status_code , 302)
		self.assertEqual(self.articlevotes1.downvote,0)
		self.assertEqual(self.articlevotes1.upvote,1)
		self.assertEqual(self.votingflag_1_2.downflag,False)
		self.assertEqual(self.votingflag_1_2.upflag,True)
		self.assertEqual(self.comm_rep1.rep,29)
		self.assertEqual(self.sys_rep1.sysrep,29)

	def test_updown_post_type3(self):
		request = initiate_updown(self,'uprecall')
		article = ArticleVotes.objects.get(article=self.article1)
		article.upvote = 1
		votingflag_1_2 = VotingFlag.objects.get(article=self.article1,user=self.user2)
		votingflag_1_2.upflag =True
		article.save()
		votingflag_1_2.save()
		response = updown(request)
		retrieve_updown(self)
		self.assertEqual(response.status_code , 302)
		self.assertEqual(self.articlevotes1.upvote,0)
		self.assertEqual(self.votingflag_1_2.upflag,False)
		self.assertEqual(self.comm_rep1.rep,23)
		self.assertEqual(self.sys_rep1.sysrep,23)	

	def test_updown_post_type4(self):
		request = initiate_updown(self,'downrecall')
		article = ArticleVotes.objects.get(article=self.article1)
		article.downvote = 1
		votingflag_1_2 = VotingFlag.objects.get(article=self.article1,user=self.user2)
		votingflag_1_2.downflag =True
		article.save()
		votingflag_1_2.save()
		response = updown(request)
		retrieve_updown(self)
		self.assertEqual(response.status_code , 302)
		self.assertEqual(self.articlevotes1.downvote,0)
		self.assertEqual(self.votingflag_1_2.downflag,False)
		self.assertEqual(self.comm_rep1.rep,27)
		self.assertEqual(self.sys_rep1.sysrep,27)

	def test_article_report_approve(self):
		request = initiate_report(self,'approve')
		response = article_report(request,self.comm.id)
		retrieve_report(self)
		self.assertEqual(response.status_code , 200)
		self.assertEqual(self.comm_rep1.rep,20)
		self.assertEqual(self.sys_rep1.sysrep,20)
		self.assertEqual(self.comm_rep2.rep,15)
		self.assertEqual(self.sys_rep2.sysrep,15)			

	def test_article_report_reject(self):
		request = initiate_report(self,'reject')
		votingflag_1_3 = VotingFlag.objects.get(article=self.article1,user=self.user3)
		votingflag_1_3.reportflag = True
		votingflag_1_3.save()
		response = article_report(request,self.comm.id)
		retrieve_report(self)
		self.assertEqual(response.status_code , 200)
		self.assertEqual(self.comm_rep3.rep,24)
		self.assertEqual(self.sys_rep3.sysrep,24)



def retrieve_updown(self):
	self.votingflag_1_2 = VotingFlag.objects.get(article=self.article1,user=self.user2)
	self.articlevotes1 = ArticleVotes.objects.get(article=self.article1)
	self.comm_rep1 = CommunityRep.objects.get(community=self.comm,user=self.user1)
	self.sys_rep1 = SystemRep.objects.get(user=self.user1)

def initiate_updown(self,type1):
	article = Articles.objects.get(title='fake_article1')
	url = reverse('updown')
	self.article1.state = self.visible
	request = self.factory.post(url,{'id':article.id,'type':type1})
	request.user = self.user2
	return request

def initiate_report(self,status):
	article = Articles.objects.get(title='fake_article1')
	url = reverse('article_report',kwargs={'pk': 1})
	article.state = self.publish
	article.save()
	article_votes = ArticleVotes.objects.get(article=self.article1)
	article_votes.published_by = self.user2
	article_votes.save()
	articlereport1 = ArticleReport.objects.get(article=self.article1)
	request = self.factory.post(url,{'pk1':articlereport1.id,'status':status})
	request.user = self.user3
	return request

def retrieve_report(self):
	self.comm_rep1 = CommunityRep.objects.get(community=self.comm,user=self.user1)
	self.sys_rep1 = SystemRep.objects.get(user=self.user1)
	self.comm_rep2 = CommunityRep.objects.get(community=self.comm,user=self.user2)
	self.sys_rep2 = SystemRep.objects.get(user=self.user2)
	self.comm_rep3 = CommunityRep.objects.get(community=self.comm,user=self.user3)
	self.sys_rep3 = SystemRep.objects.get(user=self.user3)
