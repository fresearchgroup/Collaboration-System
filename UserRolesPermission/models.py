from django.db import models
from django.contrib.auth.models import User
from .helpers import get_file_path


class ProfileImage(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    photo = models.ImageField(upload_to=get_file_path)
