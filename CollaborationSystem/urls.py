"""CollaborationSystem URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from django.contrib.auth import views as auth_views
from BasicArticle import viewsets
from BasicArticle import views as articleview
from rest_framework import routers
from UserRolesPermission import views as user_views
from Community import views as communityview
from Community import viewsets as communityviewsets
from Group import views as group_views
from machina.app import board
from UserRolesPermission import viewsets as user_viewsets

router = routers.DefaultRouter()
router.register(r'articleapi', viewsets.ArticleViewSet)
router.register(r'communityapi', communityviewsets.CommunityViewSet)

urlpatterns = [
    url(r'^$', user_views.home, name='home'),
    url(r'^admin/', admin.site.urls),
    url(r'^login/$', auth_views.LoginView.as_view(template_name='login.html'), name='login'),
    url(r'^logout/$', auth_views.LogoutView.as_view(), name='logout'),
    url(r'^signup/$', user_views.signup, name ='signup' ),
    url(r'^', include(router.urls)),
    url(r'^api/', include('rest_framework.urls', namespace='rest_framework')),

    url(r'^communities/$', communityview.display_communities, name ='display_communities'),
    url(r'^community-view/(?P<pk>\d+)/$', communityview.community_view, name='community_view'),
    url(r'^community-subscribe/$', communityview.community_subscribe, name='community_subscribe'),
    url(r'^community-unsubscribe/$', communityview.community_unsubscribe, name='community_unsubscribe'),
    url(r'^community-article-create/$', communityview.community_article_create, name='community_article_create'),

    url(r'^comments/', include('django_comments_xtd.urls')),

    url(r'^articles/$', articleview.display_articles, name='display_articles'),
    url(r'^article-view/(?P<pk>\d+)/$', articleview.view_article, name='article_view'),
    url(r'^article-edit/(?P<pk>\d+)/$', articleview.edit_article, name='article_edit'),
    url(r'^article-delete/(?P<pk>\d+)/$', articleview.delete_article, name='article_delete'),
    url(r'^article-revision/(?P<pk>\d+)/$', articleview.SimpleModelHistoryCompareView.as_view(template_name='revision_article.html'), name='article_revision' ),

    url(r'^mydashboard/$', user_views.user_dashboard, name='user_dashboard'),
    url(r'^community-group-create/$', communityview.community_group, name='community_group'),

    url(r'^group-view/(?P<pk>\d+)/$', group_views.group_view, name='group_view'),
    url(r'^group-subscribe/$', group_views.group_subscribe, name='group_subscribe'),
    url(r'^group-unsubscribe/$', group_views.group_unsubscribe, name='group_unsubscribe'),
    url(r'^group-article-create/$', group_views.group_article_create, name='group_article_create'),

    url(r'^forum/', include(board.urls)),
    url(r'^registrationapi/$', user_viewsets.RegistrationViewsets.as_view(), name='account-create'),

    url(r'^request_community_creation/$', communityview.request_community_creation, name='request_community_creation'),
    url(r'^handle_community_creation_requests/$', communityview.handle_community_creation_requests, name='handle_community_creation_requests'),

    url(r'^updateprofile/$', user_views.update_profile, name='update_profile'),

]
