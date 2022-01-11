from django.shortcuts import render
from Community.models import CommunityArticles, CommunityMedia
from django.contrib.contenttypes.models import ContentType
from browsehistory.models import BrowseHistory
from BasicArticle.models import Articles
from Media.models import Media

# Create your views here.
def my_browse_history(request):
    if request.user.is_authenticated:
        articlebrowsehistory = BrowseHistory.objects.filter(user=request.user, content_type=ContentType.objects.get_for_model(Articles))
        articleids = []
        for history in articlebrowsehistory:
            articleids.append(history.object_id)
        recentarticles = CommunityArticles.objects.filter(article__pk__in=articleids)

        mediabrowsehistory = BrowseHistory.objects.filter(user=request.user, content_type=ContentType.objects.get_for_model(Media))
        mediaids = []
        for history in mediabrowsehistory:
            mediaids.append(history.object_id)
        recentmedia = CommunityMedia.objects.filter(media__pk__in=mediaids)

        return render(request, 'mybrowsehistory.html', {'recentarticles':recentarticles, 'recentmedia':recentmedia})
    else:
        return redirect('login')
