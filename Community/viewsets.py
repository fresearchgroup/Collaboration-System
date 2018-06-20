from .models import Community, CommunityArticles
from .serializers import CommunitySerializer, CommunityArticlesSerializer
from rest_framework import generics
import datetime, time
from django.utils import timezone
# Create your views here.
today = datetime.date.today()
yesterday = today - datetime.timedelta(1)
yesterday_start = timezone.make_aware(datetime.datetime.combine(yesterday, datetime.time()))
yesterday_end = timezone.make_aware(datetime.datetime.combine(today, datetime.time()))

class CommunityViewSet(generics.ListAPIView):
	queryset = Community.objects.filter(created_at__range=[yesterday_start,yesterday_end])
	serializer_class = CommunitySerializer


class CommunityArticleViewsets(generics.ListAPIView):
	serializer_class = CommunityArticlesSerializer

	def get_queryset(self):
		return CommunityArticles.objects.filter(article__state__name='publish', article__published_on__range=[yesterday_start, yesterday_end])