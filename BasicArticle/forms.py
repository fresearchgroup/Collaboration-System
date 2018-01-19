from django import forms
from captcha.fields import CaptchaField

class NewArticleForm(forms.Form):
	title  = forms.CharField()
	body   = forms.CharField(widget=forms.Textarea)
