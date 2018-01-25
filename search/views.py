from django.shortcuts import render, redirect
import pysolr

def search_articles(request):
	if request.method == 'POST':
		searchcriteria = request.POST['searchcriteria']
		conn=pysolr.Solr('http://127.0.0.1:8983/solr/collab')
		articles=conn.search('title:'+searchcriteria+'*')
		return render(request, 'search.html',{'articles':articles})

path= "http://127.0.0.1:8983/solr/collab"

def IndexDocuments(id,title,body,date):
    conn=pysolr.Solr(path)
    docs = [{'id': id,  'title': title, 'body': body ,'created_at' : str(date) }]
    conn.add(docs)
    return
