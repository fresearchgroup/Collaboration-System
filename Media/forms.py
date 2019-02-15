
from django import forms
from .models import Media
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Field, Fieldset, Div, HTML, ButtonHolder, Submit, Hidden

class MediaCreateForm(forms.ModelForm):
	description = forms.CharField(widget=forms.Textarea)
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
		self.fields['description'].widget.attrs.update({'class': 'form-control'})
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
                Field('description'),
                Field('media_type'),
                Field('medialink','value'),
                Field('mediafile'),
                HTML("<br>"),
                ButtonHolder(Submit('submit', 'Create')),
                )
		)

