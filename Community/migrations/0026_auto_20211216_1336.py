# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2021-12-16 08:06
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Community', '0025_auto_20211210_1642'),
    ]

    operations = [
        migrations.AddField(
            model_name='requestcommunitycreationdetails',
            name='latitude',
            field=models.FloatField(null=True),
        ),
        migrations.AddField(
            model_name='requestcommunitycreationdetails',
            name='longitude',
            field=models.FloatField(null=True),
        ),
    ]