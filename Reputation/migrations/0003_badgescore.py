# -*- coding: utf-8 -*-
# Generated by Django 1.11.18 on 2019-03-15 06:12
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Reputation', '0002_auto_20190306_2109'),
    ]

    operations = [
        migrations.CreateModel(
            name='BadgeScore',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('articles_contributed_level_1', models.IntegerField(default=0)),
                ('articles_contributed_level_2', models.IntegerField(default=0)),
                ('articles_contributed_level_3', models.IntegerField(default=0)),
                ('articles_contributed_level_4', models.IntegerField(default=0)),
                ('articles_contributed_level_5', models.IntegerField(default=0)),
                ('my_articles_published_level_1', models.IntegerField(default=0)),
                ('my_articles_published_level_2', models.IntegerField(default=0)),
                ('my_articles_published_level_3', models.IntegerField(default=0)),
                ('my_articles_published_level_4', models.IntegerField(default=0)),
                ('my_articles_published_level_5', models.IntegerField(default=0)),
                ('articles_revised_by_me_level_1', models.IntegerField(default=0)),
                ('articles_revised_by_me_level_2', models.IntegerField(default=0)),
                ('articles_revised_by_me_level_3', models.IntegerField(default=0)),
                ('articles_revised_by_me_level_4', models.IntegerField(default=0)),
                ('articles_revised_by_me_level_5', models.IntegerField(default=0)),
                ('articles_published_be_me_level_1', models.IntegerField(default=0)),
                ('articles_published_be_me_level_2', models.IntegerField(default=0)),
                ('articles_published_be_me_level_3', models.IntegerField(default=0)),
                ('articles_published_be_me_level_4', models.IntegerField(default=0)),
                ('articles_published_be_me_level_5', models.IntegerField(default=0)),
            ],
        ),
    ]
