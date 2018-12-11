import datetime
from haystack import indexes
from .models import Community
from django.utils import timezone


class CommunityIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.CharField(document=True, use_template=True)
    # created_by = indexes.CharField(model_attr='created_by')
    # desc = indexes.CharField(model_attr='desc')
    created_at = indexes.DateTimeField(model_attr='created_at')

    def get_model(self):
        return Community

    def index_queryset(self, using=None):
    #     """Used when the entire index for model is updated."""
        return self.get_model().objects.filter(created_at__lte= timezone.make_aware(datetime.datetime.now()))