import datetime
from haystack import indexes
from .models import Community
from django.utils import timezone
from haystack.fields import CharField


class CommunityIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.EdgeNgramField(document=True, model_attr='name')
    # created_by = indexes.CharField(model_attr='created_by')
    
    #desc = indexes.TextField(model_attr='desc', faceted=True)
    category = indexes.CharField(model_attr='category', faceted=True)
    # name = indexes.CharField(model_attr='name', faceted=True)
    # id = indexes.CharField(model_attr='id')
    created_at = indexes.DateTimeField(model_attr='created_at')

    # for spelling suggestions
    suggestions = indexes.FacetCharField()

    def get_model(self):
        return Community

    def index_queryset(self, using=None):
    #     """Used when the entire index for model is updated."""
        return self.get_model().objects.all()