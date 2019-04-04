from rest_framework import permissions
from Community.models import CommunityMembership, Community

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
