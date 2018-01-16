from django.db import models
from django.contrib.auth.models import User
from .helpers import RandomFileName


class ProfileImage(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    photo = models.ImageField(upload_to=RandomFileName('profile'))