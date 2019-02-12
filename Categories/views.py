from django.shortcuts import render
from .models import Category
from Community.models import Community

# Create your views here.
def category_view(request, catid, commid):
	category = Category.objects.get(pk=catid)
	community = Community.objects.get(pk=commid)
	communities = Community.objects.filter(category=category, parent=community)
	return render(request, 'communities.html',{'communities':communities})
