from django.shortcuts import render, redirect
from .forms import NewArticleForm
from django.http import Http404, HttpResponse
from .models import Articles



def create_artcile(request , cid):
	if request.method == 'POST':
		form = NewArticleForm(request.POST)
		if form.is_valid():
			article = Articles.objects.create(
				title = form.cleaned_data.get('title'),
				body  = form.cleaned_data.get('body').replace("\<script ","").replace("&lt;script ","")
				)
			return article