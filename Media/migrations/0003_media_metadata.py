# -*- coding: utf-8 -*-
# Generated by Django 1.11.7 on 2019-02-18 10:05
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('metadata', '0002_auto_20190218_1005'),
        ('Media', '0002_media_medialink'),
    ]

    operations = [
        migrations.AddField(
            model_name='media',
            name='metadata',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='media_metadata', to='metadata.Metadata'),
        ),
    ]
