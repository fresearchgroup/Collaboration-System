from django.shortcuts import render, redirect
from .models import Course, Topics
from Community.models import CommunityCourses
from .forms import TopicForm

def create_course(request):
	name = request.POST['name']
	desc = request.POST['desc']
	course = Course.objects.create(name=name, desc=desc)
	return course

def create_topics(request, pk):
	if request.user.is_authenticated:
		if request.method == 'POST':
			name = request.POST['name']
			parentid = request.POST['parent']
			if Topics.objects.filter(pk=parentid).exists():
				parent = Topics.objects.get(pk=parentid)
			else:
				parent = None
			course = Course.objects.get(pk=pk)
			topic = Topics.objects.create(name = name, parent=parent, course = course )
			return topic
		else:
			course = Course.objects.get(pk=pk)
			topics = Topics.object.filter(course=course)
			return render(request, 'signup.html', {'course': course, 'topics':topics})

def course_view(request, pk):
	try:
		course = CommunityCourses.objects.get(course=pk)
		topics = Topics.objects.filter(course=pk)
#		count = course_watch(request, course.course) #Shall add this later
	except CommunityCourses.DoesNotExist:
		raise Http404
	return render(request, 'view_course.html', {'course':course, 'topics':topics})

def course_edit(request, pk):
	if request.user.is_authenticated:
		if request.method == 'POST':
			status = request.POST['status']
			if status == 'addtopic':
				create_topics(request,pk)
			if status == 'update':
				update_topic_name(request)
			if status == 'movetopic':
				move_topic(request)
			return redirect('course_edit',pk=pk)
		else:
			try:
				course = CommunityCourses.objects.get(course=pk)
				topics = Topics.objects.filter(course=pk)
				form = TopicForm(course.course)
			except CommunityCourses.DoesNotExist:
				raise Http404
			return render(request, 'edit_course.html', {'course':course, 'topics':topics,'form':form})

def update_topic_name(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			nodeid = request.POST['nodeid']
			name = request.POST['name'+nodeid]
			topic = Topics.objects.get(pk=nodeid)
			topic.name = name
			topic.save()

def move_topic(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			parent = request.POST['parent']
			if Topics.objects.filter(pk=parent).exists():
				parent = Topics.objects.get(pk=parent)
			else:
				parent = None
			topic = request.POST['topic']
			topic = Topics.objects.get(pk=topic)
			topic.parent = parent
			topic.save()
