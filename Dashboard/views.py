from django.shortcuts import render, redirect
from graphs import get_data, article_status, create

def community_dashboard(request,pk):
	data = get_data.community_view(pk)
	data_label = ['Community View']
	xlabel = "Time"
	ylabel = "Number of views"
	div_id = "communityview"
	communityview = create.data_plot(div_id, 'linechart', data, data_label, xlabel, ylabel)
	return render(request, 'community_dashboard.html',{'communityview': communityview})

def article_dashboard(request,pk):
	data = get_data.main_call(pk)
	data_label = ['Article View']
	xlabel = "Time"
	ylabel = "Number of Views"
	div_id = 'Articleviews'
	
	viewdata = create.data_plot(div_id, 'linechart', data, data_label, xlabel, ylabel)

	return render(request,'article_dashboard.html',{'viewdata': viewdata})

def user_insight_dashboard(request,pk):
	return render(request,'user_insight_dashboard.html')
