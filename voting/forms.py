from django import forms

class NewArticleForm(forms.Form):
	title  = forms.CharField()
	body   = forms.CharField(widget=forms.Textarea)
