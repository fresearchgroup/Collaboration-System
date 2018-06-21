from django.shortcuts import render, redirect
from graphs import get_data, article_status, create

from Community.models import Articles

def community_dashboard(request,pk):
	data = get_data.community_view(pk)
	data_label = ['Community View']
	xlabel = "Time"
	ylabel = "Number of views"
	div_id = "communityview"
	communityview = create.data_plot(div_id, 'linechart', data, data_label, xlabel, ylabel)
	
    # To show the trending articles in community
    # data_trending = 
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
    	
    return render(request, 'community_dashboard.html',{'communityview': communityview,'articles':articles,'status':status})

def article_dashboard(request,pk):
	data = get_data.main_call(pk)
	data_label = ['Article View']
	xlabel = "Time"
	ylabel = "Number of Views"
	div_id = 'Articleviews'
	
	viewdata = create.data_plot(div_id, 'linechart', data, data_label, xlabel, ylabel)

	return render(request,'article_dashboard.html',{'viewdata': viewdata})

def user_insight_dashboard(request,pk):
	
    # To show the trending articles in community
    # data_trending = 
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
        
    return render(request, 'community_dashboard.html',{'communityview': communityview,'articles':articles,'status':status})
