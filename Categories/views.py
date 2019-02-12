from django.shortcuts import render
from .models import Category
from Community.models import Community
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse

# Create your views here.
def category_view(request, catid, commid):
	category = Category.objects.get(pk=catid)
	community = Community.objects.get(pk=commid)
	communities = Community.objects.filter(category=category, parent=community)
	return render(request, 'communities.html',{'communities':communities})

def categories(request):
	categories = Category.objects.filter(parent=None)
	return render(request, 'categories.html',{'categories':categories})
