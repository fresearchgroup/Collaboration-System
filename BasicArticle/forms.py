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
			# fields = ['title', 'image', 'state', 'tags']
			pass
		else:
			fields = ['body', 'state', 'tags']
			# fields = ['introduction', 'architecture', 'rituals', 'ceremonies', 'tales', 'more_information', 'state', 'tags']


	def __init__(self, *args, **kwargs):
		role = kwargs.pop('role', None)
		super().__init__(*args, **kwargs)
		# self.fields['title'].widget.attrs.update({'class': 'form-control'})
		# self.fields['introduction'].widget.attrs.update({'class': 'form-control'})
		# self.fields['introduction'].required = False
		# self.fields['architecture'].widget.attrs.update({'class': 'form-control'})
		# self.fields['architecture'].required = False
		# self.fields['rituals'].widget.attrs.update({'class': 'form-control'})
		# self.fields['rituals'].required = False
		# self.fields['ceremonies'].widget.attrs.update({'class': 'form-control'})
		# self.fields['ceremonies'].required = False
		# self.fields['tales'].widget.attrs.update({'class': 'form-control'})
		# self.fields['tales'].required = False
		# self.fields['more_information'].widget.attrs.update({'class': 'form-control'})
		# self.fields['more_information'].required = False
		# self.fields['image'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["jpeg", "jpg","png"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select article image for upload...'})
		# self.fields['image'].required = False
		self.fields['body'].widget.attrs.update({'class': 'form-control'})
		self.fields['state'].widget.attrs.update({'class': 'form-control'})
		self.fields['tags'].widget.attrs.update({'class': 'form-control'})
		self.fields['tags'].required = False
		states = getStatesCommunity(self.instance.state.id, role)
		self.fields['state'].queryset = States.objects.filter(name__in=states)
		self.fields['state'].required = False

	def clean(self):
		cleaned_data = super(ArticleUpdateForm, self).clean()
		introduction_data = cleaned_data.get("introduction")
		architecture_data = cleaned_data.get("architecture")
		rituals_data = cleaned_data.get("rituals")
		ceremonies_data = cleaned_data.get("ceremonies")
		tales_data = cleaned_data.get("tales")
		more_information_data = cleaned_data.get("more_information")

		if (introduction_data == '<p>&nbsp;</p>' and architecture_data == '<p>&nbsp;</p>' and rituals_data == '<p>&nbsp;</p>' and ceremonies_data == '<p>&nbsp;</p>' and tales_data == '<p>&nbsp;</p>' and more_information_data == '<p>&nbsp;</p>'):
			msg = "Please enter information for atleast one of the categories"
			self.add_error('tags', msg)

		# if not settings.REALTIME_EDITOR:
		# 	self.fields['body'].widget.attrs.update({'class': 'form-control'})

class ArticleCreateForm(forms.ModelForm):
	class Meta:
		model = Articles
		if settings.REALTIME_EDITOR:
			# fields = ['title', 'image', 'tags']
			pass
		else:
			fields = ['body', 'tags']
			# fields = ['introduction', 'architecture', 'rituals', 'ceremonies', 'tales', 'more_information', 'tags']

	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)
		#self.fields['title'].widget.attrs.update({'class': 'form-control'})
		# self.fields['introduction'].widget.attrs.update({'class': 'form-control'})
		# self.fields['introduction'].required = False
		# self.fields['architecture'].widget.attrs.update({'class': 'form-control'})
		# self.fields['architecture'].required = False
		# self.fields['rituals'].widget.attrs.update({'class': 'form-control'})
		# self.fields['rituals'].required = False
		# self.fields['ceremonies'].widget.attrs.update({'class': 'form-control'})
		# self.fields['ceremonies'].required = False
		# self.fields['tales'].widget.attrs.update({'class': 'form-control'})
		# self.fields['tales'].required = False
		# self.fields['more_information'].widget.attrs.update({'class': 'form-control'})
		# self.fields['more_information'].required = False
		# self.fields['image'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["jpeg", "jpg","png"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select article image for upload...'})
		# self.fields['image'].required = False
		self.fields['body'].widget.attrs.update({'class': 'form-control'})
		self.fields['tags'].widget.attrs.update({'class': 'form-control'})
		self.fields['tags'].required = False
		# if not settings.REALTIME_EDITOR:
		# 	self.fields['body'].widget.attrs.update({'class': 'form-control'})

	# def clean(self):
	# 	cleaned_data = super(ArticleCreateForm, self).clean()
	# 	introduction_data = cleaned_data.get("introduction")
	# 	architecture_data = cleaned_data.get("architecture")
	# 	rituals_data = cleaned_data.get("rituals")
	# 	ceremonies_data = cleaned_data.get("ceremonies")
	# 	tales_data = cleaned_data.get("tales")
	# 	more_information_data = cleaned_data.get("more_information")

	# 	if (introduction_data == '<p>&nbsp;</p>' and architecture_data == '<p>&nbsp;</p>' and rituals_data == '<p>&nbsp;</p>' and ceremonies_data == '<p>&nbsp;</p>' and tales_data == '<p>&nbsp;</p>' and more_information_data == '<p>&nbsp;</p>'):
	# 		msg = "Please enter information for atleast one of the categories"
	# 		self.add_error('tags', msg)

