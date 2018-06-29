from django.contrib import admin
from .models import VotingFlag,ArticleVotes,ArticleReport,Badges

# Register your models here.

admin.site.register(VotingFlag)
admin.site.register(ArticleVotes)
admin.site.register(ArticleReport)
admin.site.register(Badges)
