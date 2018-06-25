from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase
from django.contrib.auth.models import User
from Community.models import Community
from Group.models import Group
from .views import updown,report,article_report,report_reasons
from .models import ArticleVotes,VotingFlag,ArticleReport,Badges
from reputation.models import CommunityRep,SystemRep

class Voting_updown(TestCase):
	def setUp(self):
		self.user = User.objects.create(username="temp_user", password="pwd", email="example@ex.com")
		self.comm = Community.objects.create(name='fake_community', desc='fake', image='/home/bharat/Pictures/einstein.jpeg',category='fake',created_by=self.user, tag_line='always fake', forum_link='jvajds')
		self.grp = Group.objects.create(name='fake_grp', desc='I am fake', image='/home/bharat/Pictures/einstein.jpeg', visibility=True, created_by=self.user)
		self.comm_rep = CommunityRep.objects.create(user=self.user, community=self.comm)
		self.sys_rep = SystemRep.objects.create(user=self.user)

	def test_updown_get(self):
		url = reverse('updown')
		response = self.client.get(url)
		self.assertEqual(response.status_code,302) #the updown view function redirects to another page. Django redirect() always return HTTP 302.

	def test_updown_post_type1(self):
		url = reverse('updown')
		data={
			'id':'1',
			'type':'upvote'
		}
		response = self.client.post(url,data)
		comm_rep = self.comm_rep
		self.assertEqual(response.status_code,302) #the updown view function redirects to another page. Django redirect() always return HTTP 302.
		self.assertEqual(comm_rep.rep,25)

	def test_updown_post_type2(self):
		url = reverse('updown')
		data={
			'id':'1',
			'type':'downvote'
		}
		response = self.client.post(url,data)
		self.assertEqual(response.status_code,302)

	def test_updown_post_type3(self):
		url = reverse('updown')
		data={
			'id':'1',
			'type':'uprecall'
		}
		response = self.client.post(url,data)
		self.assertEqual(response.status_code,302)

	def test_updown_post_type4(self):
		url = reverse('updown')
		data={
			'id':'1',
			'type':'downrecall'
		}
		response = self.client.post(url,data)
		self.assertEqual(response.status_code,302)


