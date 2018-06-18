from .models import Community, CommunityArticles
from .serializers import CommunitySerializer, CommunityArticlesSerializer
from rest_framework import viewsets, generics
import datetime
# Create your views here.

class CommunityViewSet(viewsets.ModelViewSet):
	queryset = Community.objects.all().order_by('name')
	serializer_class = CommunitySerializer


class CommunityArticleViewsets(generics.ListAPIView):
	serializer_class = CommunityArticlesSerializer

	def get_queryset(self):
		return CommunityArticles.objects.filter(article__state__name='publish', article__published_on=datetime.date.today())