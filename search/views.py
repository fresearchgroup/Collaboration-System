from django.shortcuts import render, redirect
import pysolr

def search_articles(request):
	if request.method == 'POST':
		searchcriteria = request.POST['searchcriteria']
		conn=pysolr.Solr('http://127.0.0.1:8983/solr/collab')
		articles=conn.search('title:"'+searchcriteria+'%"')
		return render(request, 'search.html',{'articles':articles})