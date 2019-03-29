
from django import forms
from .models import Media
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Field, Fieldset, Div, HTML, ButtonHolder, Submit, Hidden
from workflow.views import getStatesCommunity
from workflow.models import States

class MediaCreateForm(forms.ModelForm):
	upload_or_link = (
		('Upload', 'Upload'),
        ('Link', 'Link'),
    )
	media_type = forms.ChoiceField(choices=upload_or_link, widget=forms.RadioSelect)

	class Meta:
		model = Media
		fields = ['title', 'mediafile', 'medialink']

	def __init__(self, *args, **kwargs):
		mtype = kwargs.pop('mediatype', None)
		super().__init__(*args, **kwargs)
		self.fields['title'].widget.attrs.update({'class': 'form-control'})
		self.fields['mediafile'].required = False
		if mtype == 'IMAGE':
		    self.fields['mediafile'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["jpeg", "jpg","png"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select image for upload...'})
		if mtype == 'AUDIO':
		    self.fields['mediafile'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["mp3"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select audio for upload...'})
		if mtype == 'VIDEO':
		    self.fields['mediafile'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["mp4"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select video for upload...'})

		self.fields['medialink'].widget.attrs.update({'class': 'form-control'})
		self.fields['medialink'].hidden = True
		self.fields['medialink'].required = False
		self.fields['media_type'].initial = 'Upload'

		self.helper = FormHelper()
		self.helper.layout = Layout(
			Div(
                Field('title'),
                Field('media_type'),
                Field('medialink','value'),
                Field('mediafile'),
                HTML("<br>"),
                ButtonHolder(Submit('submit', 'Create')),
                )
		)

class MediaUpdateForm(forms.ModelForm):
	class Meta:
		model = Media
		fields = ['title', 'mediafile', 'medialink', 'state']

	def __init__(self, *args, **kwargs):
		role = kwargs.pop('role', None)
		mtype = kwargs.pop('mediatype', None)
		super().__init__(*args, **kwargs)
		self.fields['title'].widget.attrs.update({'class': 'form-control'})
		self.fields['state'].widget.attrs.update({'class': 'form-control'})
		states = getStatesCommunity(self.instance.state.name, role)
		self.fields['state'].queryset = States.objects.filter(name__in=states)
		self.fields['mediafile'].required = False
		if mtype == 'IMAGE':
		    self.fields['mediafile'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["jpeg", "jpg","png"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select image for upload...'})
		if mtype == 'AUDIO':
		    self.fields['mediafile'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["mp3"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select audio for upload...'})
		if mtype == 'VIDEO':
		    self.fields['mediafile'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["mp4"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select video for upload...'})

		self.fields['medialink'].widget.attrs.update({'class': 'form-control'})
		self.fields['medialink'].required = False

		self.helper = FormHelper()
		self.helper.layout = Layout(
			Div(
                Field('title'),
                Field('media_type'),
                Field('medialink'),
                Field('mediafile'),
				Field('state'),
                HTML("<br>"),
                ButtonHolder(Submit('submit', 'Update')),
                )
		)
