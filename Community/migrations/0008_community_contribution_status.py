# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2021-10-12 08:43
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Community', '0007_auto_20211012_0743'),
    ]

    operations = [
        migrations.AddField(
            model_name='community',
            name='contribution_status',
            field=models.CharField(choices=[('Ongoing', 'Ongoing'), ('Completed', 'Completed')], default='IMAGE', max_length=20),
        ),
    ]