
from django import forms
from .models import Community, RequestCommunityCreation
from Categories.models import Category
from mptt.forms import TreeNodeChoiceField
from haystack.forms import FacetedSearchForm
import datetime

class CommunityCreateForm(forms.ModelForm):

	x = forms.FloatField(widget=forms.HiddenInput(), required=False)
	y = forms.FloatField(widget=forms.HiddenInput(), required=False)
	width = forms.FloatField(widget=forms.HiddenInput(), required=False)
	height = forms.FloatField(widget=forms.HiddenInput(), required=False)

	class Meta:
		model = Community
		fields = ['name', 'desc', 'image', 'tag_line', 'created_by']

	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)
		self.fields['name'].widget.attrs.update({'class': 'form-control'})
		self.fields['desc'].widget.attrs.update({'class': 'form-control'})
		self.fields['image'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["jpeg", "jpg","png"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select article image for upload...'})
		self.fields['image'].required = False
		# self.fields['category'].widget.attrs.update({'class': 'form-control'})
		self.fields['tag_line'].widget.attrs.update({'class': 'form-control'})
		self.fields['created_by'].widget.attrs.update({'class': 'form-control'})
		# self.fields['category'] = TreeNodeChoiceField(queryset=Category.objects.all())

class RequestCommunityCreateForm(forms.ModelForm):
	class Meta:
		model = RequestCommunityCreation
		fields = ['name', 'desc', 'tag_line', 'purpose']

	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)
		self.fields['name'].widget.attrs.update({'class': 'form-control', 'ng-model':'name', 'ng-pattern':'/^[a-z A-Z ()]*$/'})
		self.fields['desc'].widget.attrs.update({'class': 'form-control'})
		# self.fields['category'].widget.attrs.update({'class': 'form-control'})
		self.fields['tag_line'].widget.attrs.update({'class': 'form-control', 'ng-model':'tag_line', 'ng-pattern': "/^[a-z A-Z0-9 !&()':-]*$/"})
		self.fields['purpose'].widget.attrs.update({'class': 'form-control', 'ng-model':'purpose', 'ng-pattern': "/^[a-z A-Z0-9 !&()':-]*$/"})

class CommunityUpdateForm(forms.ModelForm):

	x = forms.FloatField(widget=forms.HiddenInput(), required=False)
	y = forms.FloatField(widget=forms.HiddenInput(), required=False)
	width = forms.FloatField(widget=forms.HiddenInput(), required=False)
	height = forms.FloatField(widget=forms.HiddenInput(), required=False)

	class Meta:
		model = Community
		fields = ['name', 'desc', 'image', 'tag_line']

	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)
		self.fields['name'].widget.attrs.update({'class': 'form-control'})
		self.fields['name'].widget.attrs['readonly'] = True
		self.fields['desc'].widget.attrs.update({'class': 'form-control'})
		self.fields['image'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["jpeg", "jpg","png"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select article image for upload...'})
		self.fields['image'].required = False
		# self.fields['category'].widget.attrs.update({'class': 'form-control'})
		self.fields['tag_line'].widget.attrs.update({'class': 'form-control'})

		# if self.instance.parent:
		# 	self.fields['category'] = TreeNodeChoiceField(self.instance.parent.category.get_descendants(include_self=False))
		# else:
		# 	self.fields['category'] = TreeNodeChoiceField(queryset=Category.objects.all())

class SubCommunityCreateForm(forms.ModelForm):
	# x = forms.FloatField(widget=forms.HiddenInput())
	# y = forms.FloatField(widget=forms.HiddenInput())
	# width = forms.FloatField(widget=forms.HiddenInput())
	# height = forms.FloatField(widget=forms.HiddenInput())

	class Meta:
		model = Community
		fields = ['name', 'desc', 'image', 'tag_line', 'parent']

	def __init__(self, *args, **kwargs):
		community = kwargs.pop('community', None)
		super().__init__(*args, **kwargs)
		self.fields['name'].widget.attrs.update({'class': 'form-control'})
		self.fields['desc'].widget.attrs.update({'class': 'form-control'})
		self.fields['image'].widget.attrs.update({'class': 'file', 'data-allowed-file-extensions':'["jpeg", "jpg","png"]', 'data-show-upload':'false', 'data-show-preview':'false', 'data-msg-placeholder':'Select article image for upload...'})
		self.fields['image'].required = False
		# self.fields['category'].widget.attrs.update({'class': 'form-control'})
		# self.fields['category'].required = False
		self.fields['tag_line'].widget.attrs.update({'class': 'form-control'})
		self.fields['tag_line'].required = False
		self.fields['parent'].widget.attrs.update({'class': 'form-control'})
		self.fields['parent'].empty_label = None
		if community:
			self.fields['parent'].queryset = Community.objects.filter(pk=community.pk)
		# if community.category:
		# 	self.fields['category'] = TreeNodeChoiceField(community.category.get_descendants(include_self=False))
		# else:
		# 	self.fields['category'].queryset = Category.objects.none()



class FacetedProductSearchForm(FacetedSearchForm):

    def __init__(self, *args, **kwargs):
        data = dict(kwargs.get("data", []))
        print("data inside FacetedProductSearchForm >>>>>>>>>>>>>>>> ", str(data))
        # self.categorys = data.get('category', [])
        self.views = data.get('view', [])
        self.created_ats = data.get('date', [])
        super(FacetedProductSearchForm, self).__init__(*args, **kwargs)
		
    def search(self):
        sqs = super(FacetedProductSearchForm, self).search()
        sqs = sqs.date_facet('created_at', start_date=datetime.date(2019, 1, 1), end_date=datetime.date(2019, 4, 4), gap_by='month')
        # if self.categorys:
        #     print("checking categories >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        #     query = None
        #     for category in self.categorys:
        #         if query:
        #             query += u' OR '
        #         else:
        #             query = u''
        #         query += u'"%s"' % sqs.query.clean(category)
        #         print("query >>>>>>>>>>> ", query)
        #     sqs = sqs.narrow(u'category_exact:%s' % query)
        if self.views:
            print("checking views >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
            query = None
            for view in self.views:
                if query:
                    query += u' OR '
                else:
                    query = u''
                query += u'"%s"' % sqs.query.clean(view)
                print("query >>>>>>>>>>> ", query)
            sqs = sqs.narrow(u'views_exact:%s' % query)
        if self.created_ats:
            print("checking created_ats >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
            query = None
            for view in self.created_ats:
                if query:
                    query += u' OR '
                else:
                    query = u''
                query += u'"%s"' % sqs.query.clean(view)
                print("query >>>>>>>>>>> ", query)
            sqs = sqs.filter(created_at__gte=datetime.datetime(2018, 1, 1)).filter(created_at__lte=datetime.datetime(2020, 1, 1))
        print("sqs >>>>>>>>>>>> ", str(sqs.query))
        return sqs
