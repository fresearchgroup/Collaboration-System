
from django import forms
from .models import Metadata, Schema
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Field, Fieldset, Div, HTML, ButtonHolder, Submit, Hidden

class MetadataForm(forms.ModelForm):

	class Meta:
		model = Metadata
		exclude = ['attrs']

	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)
		self.helper = FormHelper()
		self.helper.layout = Layout(
			Div(
                Field('description'),
                HTML("<br>"),
                ButtonHolder(Submit('submit', 'Save')),
                )
		)

		for key in Schema:
			self.fields[key]=forms.CharField(label = key, required = False)