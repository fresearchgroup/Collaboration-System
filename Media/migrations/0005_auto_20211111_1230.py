# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2021-11-11 12:30
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('workflow', '0003_auto_20190318_1054'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('Media', '0004_auto_20190325_1122'),
    ]

    operations = [
        migrations.CreateModel(
            name='MediaStates',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('changedon', models.DateTimeField(auto_now_add=True, null=True)),
                ('changedby', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='mediachangedby', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.RemoveField(
            model_name='media',
            name='state',
        ),
        migrations.AddField(
            model_name='mediastates',
            name='media',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='mediainfo', to='Media.Media'),
        ),
        migrations.AddField(
            model_name='mediastates',
            name='state',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='mediaworkflow', to='workflow.States'),
        ),
    ]
