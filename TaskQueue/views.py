from django.shortcuts import render, redirect
from .models import Task
from .tasks import createbulkcommunity
from django.contrib import messages
# Create your views here.

def upload_task(request):
    if request.user.is_superuser:
        if request.method == 'POST':
            name = request.POST['name']
            task = request.FILES['taskfile']
            Task.objects.create(name=name, tfile=task)
            return redirect('upload_task')
        else:
            task = Task.objects.all()
            return render(request, 'tasks.html',{'task':task})
    else:
        return redirect('home')

def run_task(request):
    if request.user.is_superuser:
        if request.method == 'POST':
            taskid = request.POST['task']
            task = Task.objects.get(pk=taskid)
            createbulkcommunity.delay(task)
            messages.success(self.request, 'We are generating your random users! Wait a moment and refresh this page.')
            return redirect('upload_task')
        else:
            return redirect('upload_task')
    else:
        return redirect('home')
