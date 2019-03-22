from rest_framework import permissions
from Community.models import CommunityMembership, Community

class IsCommunityMember(permissions.BasePermission):

	def has_permission(self, request, view):
		return CommunityMembership.objects.filter(user=request.user, community=Community.objects.get(pk=view.kwargs['pk']))
