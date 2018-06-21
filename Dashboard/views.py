from django.shortcuts import render, redirect
from graphs import get_data, article_status, create
from BasicArticle.models import Articles
from Community.models import Community
from django.http import Http404, HttpResponse
from django.shortcuts import get_object_or_404
import requests

from Community.models import Articles

def community_dashboard(request,pk):
    community = get_object_or_404(Community, pk = pk)
    data = get_data.community_view(pk)
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
    # data_trending = requests.get('/logapi/event/article/view/?community-id={{pk}}&agg_type=terms&agg_field=article-id&limit=5')
    data_trending = {
        'status': 200,
        "total_hits": 10,
        "logs": [
            {
                'key': 4,
                'count': 20, 
            },
            {
                'key': 2,
                'count': 30,
            },  
            {
                'key': 3,
                'count': 10,
            }
        ]
    } 
    articles=[]
    status = 'found'
    if data_trending['status'] == 200:
        articles_keys = []
        for item in data_trending['logs']:
            articles_keys.append(item['key'])
        if len(articles_keys) == 0:
            status = 'not found'
        else:
            for key in articles_keys:
                article_title = Articles.objects.filter(id=key).first().title
                articles.append({'article_id':key,'article_title':article_title})
    else:
        status = 'not found'
        
    return render(request, 'community_dashboard.html',{'communityview': communityview,'articles':articles,'status':status, 'topview': topview})

def article_dashboard(request,pk):
    article = get_object_or_404(Articles, pk = pk)
    data = get_data.main_call(pk)
    data_label = ['Article View']
    xlabel = "Time"
    ylabel = "Number of Views"
    div_id = 'Articleviews'

    viewdata = create.data_plot(div_id, 'linechart', data, data_label, xlabel, ylabel)

    return render(request,'article_dashboard.html',{'viewdata': viewdata})

def user_insight_dashboard(request,pk):
    # To show the trending articles in community
    # data_trending = requests.get('/logapi/user/{{pk}}/event/article/view/'?after=170-1-1T0:0:0&limit=5)
    data_trending = {
        'status': 200,
        "total_hits": 10,
        "logs": [
            {
                'key': 4,
                'count': 20, 
            },
            {
                'key': 2,
                'count': 30,
            },  
            {
                'key': 3,
                'count': 10,
            }
        ]
    } 
    articles=[]
    status = 'found'
    if data_trending['status'] == 200:
        articles_keys = []
        for item in data_trending['logs']:
            articles_keys.append(item['key']['event']['article-id'])
        if len(articles_keys) == 0:
            status = 'not found'
        else:
            for key in articles_keys:
                article_title = Articles.objects.filter(id=key).first().title
                articles.append({'article_id':key,'article_title':article_title})
    else:
        status = 'not found'
    user=request.user
    state_list = article_status.findstates(article_status.find_articles(user))
    res2 = create.data_plot('chart2','piechart', article_status.plot_data(state_list), article_status.labels(state_list))

    user_articles = article_status.find_articles(request.user)
    user_toparticles = article_status.topfive(user_articles)
    user_article_id = [item[1] for item in user_toparticles]
    user_viewcount = [item[0] for item in user_toparticles]
    user_article_title = article_status.get_article_name(user_article_id)

    usertop_id = 'usertop'
    usertopview = create.data_plot(usertop_id, 'bargraph', [user_viewcount],['View'], 'Article Title', 'Number of views', user_article_title)
        
    return render(request, 'user_insight_dashboard.html',{'articles':articles,'status':status,'res2':res2,'usertopview':usertopview})

