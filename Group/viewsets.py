from .models import Group, GroupArticles
from .serializers import GroupSerializer, GroupArticlesSerializer
from rest_framework import generics
import datetime, time
from django.utils import timezone
# Create your views here.
today = datetime.date.today()
yesterday = today - datetime.timedelta(1)
yesterday_start = timezone.make_aware(datetime.datetime.combine(yesterday, datetime.time()))
yesterday_end = timezone.make_aware(datetime.datetime.combine(today, datetime.time()))

class GroupViewSet(generics.ListAPIView):
	queryset = Group.objects.filter(created_at__range=[yesterday_start, yesterday_end])
	serializer_class = GroupSerializer


class GroupArticleViewsets(generics.ListAPIView):
	serializer_class = GroupArticlesSerializer

	def get_queryset(self):
		return GroupArticles.objects.filter(article__state__name='publish', article__published_on__range=[yesterday_start, yesterday_end])