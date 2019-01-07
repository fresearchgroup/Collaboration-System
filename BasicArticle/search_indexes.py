import datetime
from haystack import indexes
from .models import Articles
from django.utils import timezone


class ArticlesIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.CharField(document=True, model_attr='title')
    # created_by = indexes.CharField(model_attr='created_by')
    created_at = indexes.DateTimeField(model_attr='created_at')

    def get_model(self):
        return Articles

    def index_queryset(self, using=None):
        """Used when the entire index for model is updated."""
        return self.get_model().objects.all()