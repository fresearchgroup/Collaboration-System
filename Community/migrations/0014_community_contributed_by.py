# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2021-11-09 06:06
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('Community', '0013_auto_20211109_0327'),
    ]

    operations = [
        migrations.AddField(
            model_name='community',
            name='contributed_by',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='contributed_by', to=settings.AUTH_USER_MODEL),
        ),
    ]