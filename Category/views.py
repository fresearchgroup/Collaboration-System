from django.shortcuts import render
from .models import Category, GroupCategory

# Create your views here.

def create_group_category(request, group, community):
	categoryid = request.POST['grpcategory']
	category = Category.objects.get(pk=categoryid)
	GroupCategory.objects.create(category=category, group=group, community=community)
