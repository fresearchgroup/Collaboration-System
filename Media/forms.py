
from django import forms
from .models import Media

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

