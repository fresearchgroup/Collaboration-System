from django.shortcuts import render, redirect
from .models import Course, Topics, Links
from Community.models import CommunityCourses
from .forms import TopicForm
from django.http import Http404, HttpResponse

def create_course(request):
	title = request.POST['name']
	body = request.POST['desc']
	course = Course.objects.create(title=title, body=body)
	return course

def create_topics(request, pk):
	course = Course.objects.get(pk=pk)
	name = request.POST['name']
	parentid = request.POST['parent']
	if parentid == '':
		parent = None
	else:
		parent = Topics.objects.get(pk=parentid)
	topic = Topics.objects.create(name = name, parent=parent, course = course )
	return topic

def course_view(request, pk):
	try:
		course = CommunityCourses.objects.get(course=pk)
		topics = Topics.objects.filter(course=pk)
		topic = topics.first()
		links = Links.objects.filter(topics = topic)
#		count = course_watch(request, course.course) #Shall add this later
	except CommunityCourses.DoesNotExist:
		raise Http404
	return render(request, 'view_course.html', {'course':course, 'topics':topics,'links':links})

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
			if status == 'deletetopic':
				delete_topic(request)
			return redirect('course_edit',pk=pk)
		else:
			try:
				course = CommunityCourses.objects.get(course=pk)
				topics = Topics.objects.filter(course=pk)
				form = TopicForm(course.course)
			except CommunityCourses.DoesNotExist:
				raise Http404
			return render(request, 'edit_course.html', {'course':course, 'topics':topics,'form':form})
	else:
		return redirect('login')

def update_topic_name(request):
	nodeid = request.POST['nodeid']
	name = request.POST['name'+nodeid]
	topic = Topics.objects.get(pk=nodeid)
	topic.name = name
	topic.save()

def move_topic(request):
	parent = request.POST['parent']
	if parent == '':
		parent = None
	else:
		parent = Topics.objects.get(pk=parent)
	topic = request.POST['topic']
	topic = Topics.objects.get(pk=topic)
	topic.parent = parent
	topic.save()

def delete_topic(request):
	deletenodeid = request.POST['deletenodeid']
	topic = Topics.objects.filter(pk=deletenodeid).delete()

def manage_resource(request, pk):
	if request.user.is_authenticated:
		if request.method=='POST':
			topicid =request.POST['topic']
			topic = Topics.objects.get(pk=topicid)
			topic_type = request.POST['topic_type']
			if topic_type=='Youtube' or topic_type=='External':
				topic_link=request.POST['topic_link']
				topic_description=request.POST['topic_description']
				link = Links.objects.create(link = topic_link, desc= topic_description, topics = topic, types=topic_type)
				return redirect('course_view',pk=pk)
			elif topic_type=='PublishedArticle':
				article_chosen=request.POST[article_chosen]
				return redirect('course_view',pk=pk)
		else:
			try:
				course = CommunityCourses.objects.get(course=pk)
				topics = Topics.objects.filter(course=pk)
			except CommunityCourses.DoesNotExist:
				raise Http404
			return render(request, 'manage_resource.html', {'course':course, 'topics':topics})
	else:
		return redirect('course_view',pk=pk)
