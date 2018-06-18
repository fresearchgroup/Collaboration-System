from .models import Community, CommunityArticles
from .serializers import CommunitySerializer, CommunityArticlesSerializer
from rest_framework import viewsets, generics
import datetime, time
# Create your views here.
today = datetime.date.today()
tomorrow = today + datetime.timedelta(1)

class CommunityViewSet(viewsets.ModelViewSet):
	queryset = Community.objects.filter(created_at__range=[today, tomorrow])
	serializer_class = CommunitySerializer


class CommunityArticleViewsets(generics.ListAPIView):
	serializer_class = CommunityArticlesSerializer

	def get_queryset(self):
		return CommunityArticles.objects.filter(article__state__name='publish', article__published_on=datetime.date.today())