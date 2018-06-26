from django.shortcuts import render, redirect
from graphs import get_data, article_status, create
from BasicArticle.models import Articles
from Community.models import Community
from django.http import Http404, HttpResponse
from django.shortcuts import get_object_or_404
import requests
from django.contrib.auth import login as auth_login
from django.shortcuts import render, redirect
from Community.models import Articles
from decouple import config

URL_BASIC = config('URL_BASIC')

def community_dashboard(request, pk):
    community = get_object_or_404(Community, pk = pk)
    data = get_data.view(pk,'community')
    data_label = ['Community View']
    xlabel = "Time"
    ylabel = "Number of views"
    div_id = "communityview"
    communityview = create.data_plot(div_id, 'linechart', data, data_label, xlabel, ylabel)

    articles = article_status.community_articles(pk)
    top = article_status.topfive(articles)
    article_id = [item[1] for item in top]
    view_count = [item[0] for item in top]
    article_title = article_status.get_article_name(article_id)

    top_id = "topview"
    topview = create.data_plot(top_id, 'bargraph', [view_count],['View'], 'Article Title', 'Number of views', article_title)
    
    # To show the trending articles in community
    data_trending = requests.get(URL_BASIC + 'logapi/event/article/view/?community-id={!s}&agg_type=terms&agg_field=article-id&limit=5&article-state=publish'.format(pk)).json()
    articles=[]
    status = 'found'
    if 'status code' in list(data_trending.keys()) and data_trending['status code'] == 200:
        articles_keys = []
        for item in data_trending['result']:
            articles_keys.append(item['key'])
        if len(articles_keys) == 0:
            status = 'not found'
        else:
            for key in articles_keys:
                try:
                    article_title = Articles.objects.filter(id=key).first().title
                    articles.append({'article_id':key,'article_title':article_title})
                except:
                    continue
    else:
        status = 'not found'
    print("Got Data: {!s}".format(articles)) 
    return render(request, 'community_dashboard.html',{'communityview': communityview,'articles':articles,'status':status, 'topview': topview})

def article_dashboard(request,pk):
    article = get_object_or_404(Articles, pk = pk)
    data = get_data.view(pk,'article')
    data_label = ['Article View']
    xlabel = "Time"
    ylabel = "Number of Views"
    div_id = 'Articleviews'

    viewdata = create.data_plot(div_id, 'linechart', data, data_label, xlabel, ylabel)

    print("Got Data: {!s}".format(viewdata)) 
    return render(request,'article_dashboard.html',{'viewdata': viewdata})

def user_insight_dashboard(request):

     if request.user.is_authenticated():

        # To show the trending articles in community
        data_trending = requests.get(URL_BASIC + 'logapi/user/{!s}/event/article/view/?after=1970-1-1T0:0:0&limit=1000'.format(request.user.id)).json()
        articles=[]
        status = 'found'
        articles_keys = []
        if 'status code' in list(data_trending.keys()) and data_trending['status code'] == 200:
            for item in data_trending['result']:
                articles_keys.append(item['event']['article-id'])
            if len(articles_keys) == 0:
                status = 'not found'
            else:
                used=set()
                articles_keys = [x for x in articles_keys  if x not in used and (used.add(x) or True)]
                if len(articles_keys)>5:
 	                    articles_keys=articles_keys[:5]
                print(articles_keys)
                for key in articles_keys:
                    try:
                        article_title = Articles.objects.filter(id=key).first().title
                        articles.append({'article_id':key,'article_title':article_title})
                    except:
                        continue
        else:
            status = 'not found'
        user=request.user
        state_list = article_status.extract_state(article_status.find_articles(user))
        res2 = create.data_plot('chart2','piechart', article_status.freq_state(state_list), article_status.labels(state_list))

        user_articles = article_status.find_articles(request.user)
        user_toparticles = article_status.topfive(user_articles)
        user_article_id = [item[1] for item in user_toparticles]
        user_viewcount = [item[0] for item in user_toparticles]
        user_article_title = article_status.get_article_name(user_article_id)

        usertop_id = 'usertop'
        usertopview = create.data_plot(usertop_id, 'bargraph', [user_viewcount],['View'], 'Article Title', 'Number of views', user_article_title)
            
        print("Got Data: {!s}".format(usertopview)) 
        return render(request, 'user_insight_dashboard.html',{'articles':articles,'status':status,'res2':res2,'usertopview':usertopview})

     else:
        return redirect('/login/?next=/user-insight-dashboard/')

