# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2018-05-30 07:35
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('BasicArticle', '0013_auto_20180227_1136'),
    ]

    operations = [
        migrations.AlterField(
            model_name='articles',
            name='created_by',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='articles',
            name='state',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='workflow.States'),
        ),
        migrations.AlterField(
            model_name='articleviewlogs',
            name='article',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='BasicArticle.Articles'),
        ),
    ]
