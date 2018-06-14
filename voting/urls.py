from django.conf.urls import include,url
from BasicArticle.views import view_article
from BasicArticle import views as articleview
from django.core.urlresolvers import reverse
app_name='voting'


urlpatterns = [	
	#url(r'^upvote/(?P<a_id>[0-9]+)/' , upvote , name='upvote'),
	#url(r'^downvote/(?P<a_id>[0-9]+)/' , downvote , name='downvote'),
]
