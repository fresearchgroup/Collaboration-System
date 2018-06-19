from django.contrib import admin
from .models import VotingFlag,ArticleVotes,ArticleReport

# Register your models here.

admin.site.register(VotingFlag)
admin.site.register(ArticleVotes)
admin.site.register(ArticleReport)
