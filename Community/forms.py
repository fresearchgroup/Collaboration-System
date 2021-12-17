
#from typing import ItemsView
from django import forms
from .models import Community, RequestCommunityCreation, RequestCommunityCreationDetails, Locations
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

	parent = forms.CharField(widget=forms.TextInput(attrs={'class': 'special'}))

	class Meta:
		model = RequestCommunityCreationDetails
		# fields = ['name', 'desc', 'tag_line', 'purpose', 'parent']
		fields = ['name', 'desc', 'area', 'city', 'state', 'district', 'pincode', 'parent', 'reason', 'latitude', 'longitude']

	def __init__(self, *args, **kwargs):
		community = kwargs.pop('cid', None)

		super().__init__(*args, **kwargs)
		# self.fields['name'].widget.attrs.update({'class': 'form-control', 'ng-model':'name', 'ng-pattern':'/^[a-z A-Z ()]*$/'})
		self.fields['name'].widget.attrs.update({'class': 'form-control', 'ng-model':'name'})
		self.fields['desc'].widget.attrs.update({'class': 'form-control', 'maxlength': '1000', 'rows':4})
		# self.fields['category'].widget.attrs.update({'class': 'form-control'})
		# self.fields['tag_line'].widget.attrs.update({'class': 'form-control', 'ng-model':'tag_line', 'ng-pattern': "/^[a-z A-Z0-9 !&()':-]*$/"})
		# self.fields['purpose'].widget.attrs.update({'class': 'form-control', 'ng-model':'purpose', 'ng-pattern': "/^[a-z A-Z0-9 !&()':-]*$/"})
		self.fields['area'].widget.attrs.update({'class': 'form-control'})
		self.fields['parent'].widget.attrs.update({'class': 'form-control'})
		self.fields['parent'].empty_label = None
		self.fields['parent'].widget.attrs['readonly'] = True
		self.fields['reason'].widget.attrs.update({'class': 'form-control', 'rows':4, 'cols':15})
		self.fields['reason'].required = False

		self.fields['latitude'].widget.attrs.update({'class': 'form-control'})
		self.fields['latitude'].widget.attrs['readonly'] = True
		self.fields['longitude'].widget.attrs.update({'class': 'form-control'})
		self.fields['longitude'].widget.attrs['readonly'] = True

		self.fields['state'] = forms.ChoiceField(choices=[('', '---------')] + [(item,item) for item in Locations.objects.all().values_list('state', flat=True).order_by('state').distinct()])
		self.fields['state'].widget.attrs.update({'class': 'form-control'})
		self.fields['district'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.none()])
		self.fields['district'].widget.attrs.update({'class': 'form-control'})
		self.fields['city'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.none()])
		self.fields['city'].widget.attrs.update({'class': 'form-control'})
		self.fields['pincode'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.none()])
		self.fields['pincode'].widget.attrs.update({'class': 'form-control'})

		if 'state' in self.data:
			try:
				state = self.data.get('state')
				self.fields['district'].choices=[('', '---------')] + [('Others', 'Others')] + [(item,item) for item in Locations.objects.filter(state=state).values_list('district', flat=True).order_by('district').distinct()]
			except (ValueError, TypeError):
				pass
		
		if 'district' in self.data:
			try:
				district = self.data.get('district')
				self.fields['city'].choices=[('', '---------')] + [('Others', 'Others')]  + [(item,item) for item in Locations.objects.filter(state=state,district=district).values_list('city', flat=True).order_by('city').distinct()]
			except (ValueError, TypeError):
				pass
		
		if 'city' in self.data:
			try:
				city = self.data.get('city')
				self.fields['pincode'].choices=[('', '---------')] + [('Others', 'Others')] + [(item,item) for item in Locations.objects.filter(state=state,district=district,city=city).values_list('pincode', flat=True).order_by('pincode').distinct()]
			except (ValueError, TypeError):
				pass

		if community:
			community = Community.objects.get(pk=community)
			self.fields['parent'].initial = community
		# self.fields['parent'].widget.attrs.update({'class': 'form-control'})
		# self.fields['parent'].empty_label = None
		# if community:
		# 	self.fields['parent'].queryset = Community.objects.filter(pk=community)

class CommunityUpdateForm(forms.ModelForm):

	districtOthers = forms.CharField(widget=forms.TextInput(attrs={'class': 'special'}))
	cityOthers = forms.CharField(widget=forms.TextInput(attrs={'class': 'special'}))
	pincodeOthers = forms.CharField(widget=forms.TextInput(attrs={'class': 'special'}))

	class Meta:
		model = Community
		fields = ['name', 'desc', 'area', 'state', 'district', 'city', 'pincode', 'latitude', 'longitude', 'districtOthers', 'cityOthers', 'pincodeOthers']

	def __init__(self, *args, **kwargs):
		super().__init__(*args, **kwargs)
		self.fields['name'].widget.attrs.update({'class': 'form-control'})
		self.fields['name'].widget.attrs['readonly'] = True
		self.fields['desc'].widget.attrs.update({'class': 'form-control'})

		self.fields['area'].widget.attrs.update({'class': 'form-control'})

		self.fields['latitude'].widget.attrs.update({'class': 'form-control'})
		self.fields['latitude'].widget.attrs['readonly'] = True
		self.fields['longitude'].widget.attrs.update({'class': 'form-control'})
		self.fields['longitude'].widget.attrs['readonly'] = True
		self.fields['latitude'].required = False
		self.fields['longitude'].required = False

		self.fields['state'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.all().values_list('state', flat=True).order_by('state').distinct()])
		self.fields['state'].widget.attrs.update({'class': 'form-control'})

		if Locations.objects.filter(district = self.instance.district).exists():
			self.fields['district'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.filter(state=self.instance.state).values_list('district', flat=True).order_by('district').distinct()] + [('Others', 'Others')])
		else:
			self.fields['district'] = forms.ChoiceField(choices=[('Others', 'Others')] + [(item,item) for item in Locations.objects.filter(state=self.instance.state).values_list('district', flat=True).order_by('district').distinct()])
			self.fields['districtOthers'].initial = self.instance.district
			self.fields['districtOthers'].widget.attrs.update({'class': 'form-control'})
		self.fields['district'].widget.attrs.update({'class': 'form-control'})

		if Locations.objects.filter(city = self.instance.city).exists():
			self.fields['city'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.filter(state=self.instance.state,district=self.instance.district).values_list('city', flat=True).order_by('city').distinct()] + [('Others', 'Others')])
		else:
			self.fields['city'] = forms.ChoiceField(choices=[('Others', 'Others')] + [(item,item) for item in Locations.objects.filter(state=self.instance.state,district=self.instance.district).values_list('city', flat=True).order_by('city').distinct()])
			self.fields['cityOthers'].initial = self.instance.city
			self.fields['cityOthers'].widget.attrs.update({'class': 'form-control'})
		self.fields['city'].widget.attrs.update({'class': 'form-control'})

		if Locations.objects.filter(pincode = self.instance.pincode).exists():
			self.fields['pincode'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.filter(state=self.instance.state,district=self.instance.district,city=self.instance.city).values_list('pincode', flat=True).order_by('pincode').distinct()] + [('Others', 'Others')])
		else:
			self.fields['pincode'] = forms.ChoiceField(choices=[('Others', 'Others')] + [(item,item) for item in Locations.objects.filter(state=self.instance.state,district=self.instance.district,city=self.instance.city).values_list('pincode', flat=True).order_by('pincode').distinct()])
			self.fields['pincodeOthers'].initial = self.instance.pincode
			self.fields['pincodeOthers'].widget.attrs.update({'class': 'form-control'})
		self.fields['pincode'].widget.attrs.update({'class': 'form-control'})

		self.fields['pincodeOthers'].required = False
		self.fields['cityOthers'].required = False
		self.fields['districtOthers'].required = False

		if 'state' in self.data:
			try:
				state = self.data.get('state')
				self.fields['district'].choices=[('', '---------')] + [('Others', 'Others')] + [(item,item) for item in Locations.objects.filter(state=state).values_list('district', flat=True).order_by('district').distinct()]
			except (ValueError, TypeError):
				pass
		
		if 'district' in self.data:
			try:
				district = self.data.get('district')
				self.fields['city'].choices=[('', '---------')] + [('Others', 'Others')]  + [(item,item) for item in Locations.objects.filter(state=state,district=district).values_list('city', flat=True).order_by('city').distinct()]
			except (ValueError, TypeError):
				pass
		
		if 'city' in self.data:
			try:
				city = self.data.get('city')
				self.fields['pincode'].choices=[('', '---------')] + [('Others', 'Others')] + [(item,item) for item in Locations.objects.filter(state=state,district=district,city=city).values_list('pincode', flat=True).order_by('pincode').distinct()]
			except (ValueError, TypeError):
				pass

		# if self.instance.parent:
		# 	self.fields['category'] = TreeNodeChoiceField(self.instance.parent.category.get_descendants(include_self=False))
		# else:
		# 	self.fields['category'] = TreeNodeChoiceField(queryset=Category.objects.all())

class SubCommunityCreateForm(forms.ModelForm):

	class Meta:
		model = Community
		fields = ['name', 'desc', 'area', 'city', 'district', 'state', 'pincode', 'latitude', 'longitude', 'parent']

	def __init__(self, *args, **kwargs):
		community = kwargs.pop('community', None)
		super().__init__(*args, **kwargs)
		self.fields['name'].widget.attrs.update({'class': 'form-control'})
		self.fields['desc'].widget.attrs.update({'class': 'form-control'})
		self.fields['area'].widget.attrs.update({'class': 'form-control'})
		self.fields['parent'].widget.attrs.update({'class': 'form-control'})
		self.fields['parent'].empty_label = None

		self.fields['latitude'].widget.attrs.update({'class': 'form-control'})
		self.fields['latitude'].widget.attrs['readonly'] = True
		self.fields['longitude'].widget.attrs.update({'class': 'form-control'})
		self.fields['longitude'].widget.attrs['readonly'] = True

		self.fields['state'] = forms.ChoiceField(choices=[('', '---------')] + [(item,item) for item in Locations.objects.all().values_list('state', flat=True).order_by('state').distinct()])
		self.fields['state'].widget.attrs.update({'class': 'form-control'})
		self.fields['district'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.none()])
		self.fields['district'].widget.attrs.update({'class': 'form-control'})
		self.fields['city'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.none()])
		self.fields['city'].widget.attrs.update({'class': 'form-control'})
		self.fields['pincode'] = forms.ChoiceField(choices=[(item,item) for item in Locations.objects.none()])
		self.fields['pincode'].widget.attrs.update({'class': 'form-control'})

		if 'state' in self.data:
			try:
				state = self.data.get('state')
				self.fields['district'].choices=[('', '---------')] + [('Others', 'Others')] + [(item,item) for item in Locations.objects.filter(state=state).values_list('district', flat=True).order_by('district').distinct()]
			except (ValueError, TypeError):
				pass
		
		if 'district' in self.data:
			try:
				district = self.data.get('district')
				self.fields['city'].choices=[('', '---------')] + [('Others', 'Others')]  + [(item,item) for item in Locations.objects.filter(state=state,district=district).values_list('city', flat=True).order_by('city').distinct()]
			except (ValueError, TypeError):
				pass
		
		if 'city' in self.data:
			try:
				city = self.data.get('city')
				self.fields['pincode'].choices=[('', '---------')] + [('Others', 'Others')] + [(item,item) for item in Locations.objects.filter(state=state,district=district,city=city).values_list('pincode', flat=True).order_by('pincode').distinct()]
			except (ValueError, TypeError):
				pass

		if community:
			self.fields['parent'].queryset = Community.objects.filter(pk=community.pk)



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

class DocumentForm(forms.Form):
    docfile = forms.FileField(
        label='Select a file'
    )