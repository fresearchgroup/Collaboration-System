# -*- coding: utf-8 -*-
# Generated by Django 1.11.7 on 2017-11-20 10:45
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('Community', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Group',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('desc', models.TextField()),
                ('visibility', models.BooleanField()),
                ('community', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='group', to='Community.Community')),
                ('created_by', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='group', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]