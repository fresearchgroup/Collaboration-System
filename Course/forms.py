from django import forms
from .models import Course, Topics
from mptt.forms import *

class TopicForm(forms.ModelForm):
    class Meta:
        model = Topics
        fields = ('name', 'parent')

    def __init__(self, course, *args, **kwargs):
        super(TopicForm, self).__init__(*args, **kwargs)
        self.fields['parent'].queryset = Topics.objects.filter(course=course)
