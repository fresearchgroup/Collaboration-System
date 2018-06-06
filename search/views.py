from django.shortcuts import render, redirect
import pysolr
path= "http://10.129.132.103:8983/solr/collab"
def search_articles(request):
	if request.method == 'POST':
		searchcriteria = request.POST['searchcriteria']
		conn=pysolr.Solr(path)
		articles=conn.search('*'+searchcriteria+'*')
		return render(request, 'search.html',{'articles':articles})



def IndexDocuments(id,title,body,date):
    conn=pysolr.Solr(path)
    docs = [{'id': id,  'title': title, 'body': body ,'created_at' : str(date) }]
    conn.add(docs)
    return
