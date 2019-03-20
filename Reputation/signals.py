from Community.models import CommunityMembership
from .models import CommunityReputaion

def create_community_reputation(sender, instance, created, **kwargs):
  if created:
    CommunityReputaion.objects.create(user=instance.user, community=instance.community)