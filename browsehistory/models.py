from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey
from django.conf import settings

from .signals import object_viewed_signal

User = settings.AUTH_USER_MODEL


class BrowseHistory(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content_type = models.ForeignKey(ContentType, on_delete=models.SET_NULL, null=True)
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey()
    viewed_on = models.DateTimeField(auto_now_add=True)
    link = models.CharField(max_length=200)

    # def __str__(self):
    #     return "%s viewed: %s" %(self.content_object, self.viewed_on)

def object_viewed_receiver(sender, instance, request, *args, **kwargs):
    BrowseHistory.objects.create(
        user = request.user,
        content_type = ContentType.objects.get_for_model(sender),
        object_id = instance.id,
        link = request.path,
    )

object_viewed_signal.connect(object_viewed_receiver)
