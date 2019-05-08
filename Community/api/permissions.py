from rest_framework import permissions
from Community.models import CommunityMembership, Community
from django.contrib.auth.models import Group as Roles

class IsCommunityMember(permissions.BasePermission):
	message = 'You are not a member of this community'

	def has_permission(self, request, view):
		return CommunityMembership.objects.filter(user=request.user, community=Community.objects.get(pk=view.kwargs['pk'])).exists()



class IfNotCommunityMember(permissions.BasePermission):
	message = 'You are already a member of this community'

	def has_permission(self, request, view):
		if CommunityMembership.objects.filter(user=request.user, community=Community.objects.get(pk=view.kwargs['pk'])).exists():
			return False
		return True

class CanUnjoinCommunity(permissions.BasePermission):
	message = 'Cannot unjoin. You are the only admin in this community.'

	def has_permission(self, request, view):
		membership = CommunityMembership.objects.get(user=request.user, community=Community.objects.get(pk=view.kwargs['pk']))
		community_admin = Roles.objects.get(name='community_admin')
		if membership.role == community_admin:
			if CommunityMembership.objects.filter(community=Community.objects.get(pk=view.kwargs['pk']),role=community_admin).count() < 2:
				return False
		return True