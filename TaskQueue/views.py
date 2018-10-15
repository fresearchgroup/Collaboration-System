from django.shortcuts import render, redirect
from .models import Task
# Create your views here.

def upload_task(request):
    if request.user.is_superuser:
        if request.method == 'POST':
            name = request.POST['name']
            task = request.POST['file']
            Task.objects.create(name=name, task=task)
            return redirect('upload_task')
        else:
            task = Task.objects.all()
            return render('tasks.html',{'task':task})
    else:
        return redirect('home')
