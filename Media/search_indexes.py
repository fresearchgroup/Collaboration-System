import datetime
from haystack import indexes
from .models import Media
from django.utils import timezone
from haystack.fields import CharField


class MediaIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.EdgeNgramField(document=True, model_attr='title')
    #category = indexes.CharField(model_attr='category', faceted=True)
    mediafile = indexes.CharField(model_attr='mediafile')
    state = indexes.CharField(model_attr='state')
    

    # for spelling suggestions
    #suggestions = indexes.FacetCharField()

    def get_model(self):
        return Media

    def index_queryset(self, using=None):
    #     """Used when the entire index for model is updated."""
        return self.get_model().objects.all()