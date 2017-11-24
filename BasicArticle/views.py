from django.shortcuts import render, redirect
from .forms import NewArticleForm
from django.http import Http404, HttpResponse
from .models import Articles

def display_articles(request):
	articles=Articles.objects.all()
	return render(request, 'articles.html',{'articles':articles})

def create_article(request):
	if request.method == 'POST':
		form = NewArticleForm(request.POST)
		if form.is_valid():
			article = Articles.objects.create(
				title = form.cleaned_data.get('title'),
				body  = form.cleaned_data.get('body').replace("\<script ","").replace("&lt;script ","")
				)
			return article

def view_article(request, pk):
    try:
        article = Articles.objects.get(pk=pk)
        #article.body=str(article.body).replace("&lt;", "<").replace("&gt;",">");
    except Articles.DoesNotExist:
        raise Http404
    return render(request, 'view_article.html', {'article': article})


def edit_article(request, pk):

	if request.method == 'POST':
		form = NewArticleForm(request.POST)
		if form.is_valid():
			article = Articles.objects.get(pk=pk)
			article.title = form.cleaned_data.get('title')
			article.body = form.cleaned_data.get('body')
			article.save(update_fields=["title","body"])
			return redirect('article_view',pk=article.pk)
	else:
		try:
			article = Articles.objects.get(pk=pk)
		except Articles.DoesNotExist:
			raise Http404
		return render(request, 'edit_article.html', {'article': article})
