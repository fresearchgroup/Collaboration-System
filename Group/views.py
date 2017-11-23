from django.shortcuts import render, redirect
from django.http import Http404, HttpResponse
from .models import Group



def create_group(request):
	if request.method == 'POST':
		name = request.POST['name']
		desc = request.POST['desc']
		visibility = request.POST['visibility']
		group = Group.objects.create(
			name = name,
			desc  = desc,
			visibility = visibility
			)
		return group

def group_view(request, pk):
    try:
        group = Group.objects.get(pk=pk)
    except Group.DoesNotExist:
        raise Http404
    return render(request, 'groupview.html', {'group': group})

def group_subscribe(request):
	return redirect('login')

def group_unsubscribe(request):
	return redirect('login')
