from django.shortcuts import render, redirect
from .models import Metadata

# Create your views here.
def create_metadata(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			description = request.POST['description']
			metadata = Metadata.objects.create(
				description = description,
				)
			return metadata
	else:
		return redirect('login')