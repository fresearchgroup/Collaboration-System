import datetime
from haystack import indexes
from .models import Community
from django.utils import timezone


class CommunityIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.EdgeNgramField(document=True, model_attr='name')
    # created_by = indexes.CharField(model_attr='created_by')
    # desc = indexes.CharField(model_attr='desc')
    # name = indexes.CharField(model_attr='name')
    # id = indexes.CharField(model_attr='id')
    created_at = indexes.DateTimeField(model_attr='created_at')

    def get_model(self):
        return Community

    def index_queryset(self, using=None):
    #     """Used when the entire index for model is updated."""
        return self.get_model().objects.all()