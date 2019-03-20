from django import forms
from .models import Articles
from workflow.views import getStatesCommunity
from workflow.models import States
from django.conf import settings

class NewArticleForm(forms.Form):
	title  = forms.CharField()
	body   = forms.CharField(widget=forms.Textarea)


class ArticleUpdateForm(forms.ModelForm):
	class Meta:
		model = Articles
		if settings.REALTIME_EDITOR:
			fields = ['title', 'image', 'state', 'tags']
		else:
			fields = ['title', 'body', 'image', 'state', 'tags']

	def __init__(self, *args, **kwargs):
		role = kwargs.pop('role', None)
		super().__init__(*args, **kwargs)
		self.fields['title'].widget.attrs.update({'class': 'form-control'})
		self.fields['image'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["jpeg", "jpg","png"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select article image for upload...'})
		self.fields['image'].required = False
		self.fields['state'].widget.attrs.update({'class': 'form-control'})
		self.fields['tags'].widget.attrs.update({'class': 'form-control'})
		states = getStatesCommunity(self.instance.state.name, role)
		self.fields['state'].queryset = States.objects.filter(name__in=states)

		if not settings.REALTIME_EDITOR:
			self.fields['body'].widget.attrs.update({'class': 'form-control'})

class ArticleCreateForm(forms.ModelForm):
	class Meta:
		model = Articles
		if settings.REALTIME_EDITOR:
			fields = ['title', 'image', 'tags']
		else:
			fields = ['title', 'body', 'image', 'tags']

	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)
		self.fields['title'].widget.attrs.update({'class': 'form-control'})
		self.fields['image'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["jpeg", "jpg","png"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select article image for upload...'})
		self.fields['image'].required = False
		self.fields['tags'].widget.attrs.update({'class': 'form-control'})
		if not settings.REALTIME_EDITOR:
			self.fields['body'].widget.attrs.update({'class': 'form-control'})
