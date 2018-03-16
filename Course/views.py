from django.shortcuts import render
from .models import Course, Topics
from Community.models import CommunityCourses

def create_course(request):
	name = request.POST['name']
	desc = request.POST['desc']
	course = Course.objects.create(name=name, desc=desc)
	return course

def create_topics(request, pk):
	if request.user.is_authenticated:
		if request.method == 'POST':
			name = request.POST['name']
			parentid = request.POST['parentid']
			if Topics.objects.filter(pk=parentid).exist():
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
