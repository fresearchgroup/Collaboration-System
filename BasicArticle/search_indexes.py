import datetime
from haystack import indexes
from .models import Articles
from django.utils import timezone


class ArticlesIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.CharField(document=True, use_template=True)
    # created_by = indexes.CharField(model_attr='created_by')
    published_on = indexes.DateTimeField(model_attr='published_on')

    def get_model(self):
        return Articles

    def index_queryset(self, using=None):
        """Used when the entire index for model is updated."""
        return self.get_model().objects.filter(published_on__lte= timezone.make_aware(datetime.datetime.now()))