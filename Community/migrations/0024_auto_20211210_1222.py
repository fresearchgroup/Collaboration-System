# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2021-12-10 06:52
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Community', '0023_auto_20211203_2115'),
    ]

    operations = [
        migrations.AddField(
            model_name='mergedarticles',
            name='document_sent',
            field=models.CharField(max_length=500, null=True),
        ),
        migrations.AddField(
            model_name='mergedarticlestates',
            name='document_sent',
            field=models.CharField(max_length=500, null=True),
        ),
    ]