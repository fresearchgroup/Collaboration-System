# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2021-10-21 13:07
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Community', '0010_requestcommunitycreation_parent'),
    ]

    operations = [
        migrations.AddField(
            model_name='requestcommunitycreation',
            name='area',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AddField(
            model_name='requestcommunitycreation',
            name='city',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AddField(
            model_name='requestcommunitycreation',
            name='pincode',
            field=models.PositiveIntegerField(null=True),
        ),
        migrations.AddField(
            model_name='requestcommunitycreation',
            name='state',
            field=models.CharField(max_length=30, null=True),
        ),
    ]
