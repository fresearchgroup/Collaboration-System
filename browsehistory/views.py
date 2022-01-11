from django.shortcuts import render
from Community.models import CommunityArticles, CommunityMedia
from django.contrib.contenttypes.models import ContentType
from browsehistory.models import BrowseHistory
from BasicArticle.models import Articles
from Media.models import Media

# Create your views here.
def my_browse_history(request):
    if request.user.is_authenticated:
        articlebrowsehistory = BrowseHistory.objects.filter(user=request.user, content_type=ContentType.objects.get_for_model(Articles)).order_by('-viewed_on')
        articleids = []
        for history in articlebrowsehistory:
            if not any(history.object_id in sublist for sublist in articleids):
                articleids.append([history.object_id, history.viewed_on])
        recentarticles = CommunityArticles.objects.filter(article__pk__in=[i[0] for i in articleids])
        for recent in recentarticles:
            for id in articleids:
                if recent.article.pk == id[0]:
                    recent.accessedon = id[1]


        mediabrowsehistory = BrowseHistory.objects.filter(user=request.user, content_type=ContentType.objects.get_for_model(Media)).order_by('-viewed_on')
        mediaids = []
        for history in mediabrowsehistory:
            if not any(history.object_id in sublist for sublist in mediaids):
                mediaids.append([history.object_id, history.viewed_on])
        recentmedia = CommunityMedia.objects.filter(media__pk__in=[i[0] for i in mediaids])
        for recent in recentmedia:
            for id in mediaids:
                if recent.media.pk == id[0]:
                    recent.accessedon = id[1]

        return render(request, 'mybrowsehistory.html', {'recentarticles':recentarticles, 'recentmedia':recentmedia})
    else:
        return redirect('login')
