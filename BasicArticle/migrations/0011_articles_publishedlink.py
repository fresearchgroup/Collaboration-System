# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2021-11-29 07:17
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('BasicArticle', '0010_articles_state'),
    ]

    operations = [
        migrations.AddField(
            model_name='articles',
            name='publishedlink',
            field=models.CharField(max_length=200, null=True),
        ),
    ]
