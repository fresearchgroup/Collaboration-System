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
from django.conf import settings
from django.conf.urls.static import static
from webcontent import views as web
from Course import views as courseview
from Group import viewsets as groupviewsets
import notifications.urls
from Dashboard import views as dashboardview
from Recommendation_API import views
from Reputation import views as repuationview
from Media import views as mediaview
from TaskQueue import views as taskview
from Categories import views as categoryview

router = routers.DefaultRouter()
#router.register(r'articleapi', viewsets.ArticleViewSet)

urlpatterns = [
    url(r'^$', user_views.home, name='home'),
    url(r'^admin/', admin.site.urls),
    url(r'^login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True), name='login'),
    url(r'^logout/$', auth_views.LogoutView.as_view(), name='logout'),
    url(r'^signup/$', user_views.signup, name ='signup' ),
    url(r'^', include(router.urls)),
    url(r'^api/', include('rest_framework.urls', namespace='rest_framework')),

    url(r'^activity/', include('actstream.urls')),

    url(r'^auth/', include('social_django.urls', namespace='social')),

    url(r'^communities/$', communityview.display_communities, name ='display_communities'),
    url(r'^community-view/(?P<pk>\d+)/$', communityview.community_view, name='community_view'),
    url(r'^community-subscribe/$', communityview.community_subscribe, name='community_subscribe'),
    url(r'^community-unsubscribe/$', communityview.community_unsubscribe, name='community_unsubscribe'),
    url(r'^community-article-create/(?P<pk>\d+)/$', articleview.ArticleCreateView.as_view(), name='community_article_create'),
    url(r'^comments/', include('django_comments_xtd.urls')),

    url(r'^articles/$', articleview.display_articles, name='display_articles'),
    url(r'^article-view/(?P<pk>\d*)/$', articleview.view_article, name='article_view'),
    url(r'^article-reports/(?P<pk>\d*)/$', articleview.reports_article, name='article_reports'),
    url(r'^ajax/article_text/(?P<pk>\d*)/$', articleview.article_text, name='article_text'),

    url(r'^h5p-view/(?P<pk>\d*)/$', communityview.h5p_view, name='h5p_view'),
    url(r'^article-edit/(?P<pk>\d*)/$', articleview.ArticleEditView.as_view(), name='article_edit'),
    url(r'^article-delete/(?P<pk>\d*)/$', articleview.delete_article, name='article_delete'),
    url(r'^article-revision/(?P<pk>\d*)/$', articleview.SimpleModelHistoryCompareView.as_view(template_name='revision_article.html'), name='article_revision' ),

    url(r'^mydashboard/$', user_views.user_dashboard, name='user_dashboard'),
    url(r'^community-group-create/(?P<pk>\d+)/$', communityview.CreateSubCommunityView.as_view(), name='community_group'),

    url(r'^group-view/(?P<pk>\d+)/$', group_views.group_view, name='group_view'),
    url(r'^group-subscribe/$', group_views.group_subscribe, name='group_subscribe'),
    url(r'^group-unsubscribe/$', group_views.group_unsubscribe, name='group_unsubscribe'),
    url(r'^group-article-create/1$', group_views.group_article_create, name='group_article_create'),
    url(r'^group-article-create/2/(?P<pk>\d+)/$', group_views.group_article_create_body, name='group_article_create_body'),
    url(r'^handle-group-invitations/$', group_views.handle_group_invitations, name='handle_group_invitations'),

    url(r'^group-feed/(?P<pk>\d+)/$', group_views.feed_content, name='group_feed'),

    url(r'^forum/', include(board.urls)),
    url(r'^registrationapi/$', user_viewsets.RegistrationViewsets.as_view(), name='account-create'),

    url(r'^request_community_creation/$', communityview.RequestCommunityCreationView.as_view(), name='request_community_creation'),
    url(r'^handle_community_creation_requests/$', communityview.handle_community_creation_requests, name='handle_community_creation_requests'),

    url(r'^updateprofile/$', user_views.update_profile, name='update_profile'),
    url(r'^uploadphoto/$', user_views.upload_image, name='upload_photo'),

    url(r'^manage_community/(?P<pk>\d+)/$', communityview.manage_community, name='manage_community'),

    url(r'^manage_group/(?P<pk>\d+)/$', group_views.manage_group, name='manage_group'),

    url(r'^myprofile/$', user_views.view_profile, name='view_profile'),

    url(r'^userprofile/(?P<username>[\w.@+-]+)/$', user_views.display_user_profile, name='display_user_profile'),

    url(r'^update_group_info/(?P<pk>\d+)/$', group_views.update_group_info, name='update_group_info'),
    url(r'^update_community_info/(?P<pk>\d+)/$', communityview.UpdateCommunityView.as_view(), name='update_community_info'),

    url(r'^create_community/$', communityview.CreateCommunityView.as_view(), name='create_community'),

    url(r'^community_content/(?P<pk>\d+)/$', communityview.community_content, name='community_content'),
    url(r'^community_feed/(?P<pk>\d+)/$', communityview.feed_content, name='community_feed'),

    url(r'^reset/$',
    auth_views.PasswordResetView.as_view(
        template_name='password_reset.html',
        email_template_name='password_reset_email.html',
        subject_template_name='password_reset_subject.txt'
    ),
    name='password_reset'),
    url(r'^reset/done/$',
    auth_views.PasswordResetDoneView.as_view(template_name='password_reset_done.html'),
    name='password_reset_done'),
     url(r'^reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>[0-9A-Za-z]{1,13}-[0-9A-Za-z]{1,20})/$',
    auth_views.PasswordResetConfirmView.as_view(template_name='password_reset_confirm.html'),
    name='password_reset_confirm'),
    url(r'^reset/complete/$',
    auth_views.PasswordResetCompleteView.as_view(template_name='password_reset_complete.html'),
    name='password_reset_complete'),
    url(r'^reset/complete/$', auth_views.PasswordResetCompleteView.as_view
      (template_name='password_reset_complete.html') ,name='password_reset_complete'),

    url(r'^settings/password/$', auth_views.PasswordChangeView.as_view(template_name='password_change.html'),
    name='password_change'),
    url(r'^settings/password/done/$', auth_views.PasswordChangeDoneView.as_view(template_name='password_change_done.html'),
    name='password_change_done'),

    url(r'^group_content/(?P<pk>\d+)/$', group_views.group_content, name='group_content'),
    url(r'^FAQs/$', web.FAQs, name ='FAQs' ),
    url(r'^search/', include('haystack.urls')),

    url(r'^feedback/$', web.provide_feedback, name ='provide_feedback' ),
    url(r'^contact_us/$', web.contact_us, name ='contact_us' ),
    url(r'^create_faq/$', web.create_faq, name ='create_faq' ),

    url(r'^check_user/$', user_views.username_exist, name ='check_user' ),
    url(r'^favourites/$', user_views.favourites, name ='favourites' ),

    url(r'^community-course-create/$', communityview.community_course_create, name='community_course_create'),
    url(r'^community-h5p-create/$', communityview.community_h5p_create, name='community_h5p_create'),
    url(r'^group-h5p-create/$', group_views.group_h5p_create, name='group_h5p_create'),
    url(r'^course-view/(?P<pk>\d*)/$', courseview.course_view, name='course_view'),
    url(r'^course-edit/(?P<pk>\d*)/$', courseview.course_edit, name='course_edit'),
    url(r'^courses/$', courseview.display_courses, name='display_courses'),
    url(r'^manage-resource/(?P<pk>\d+)/$', courseview.manage_resource, name='manage_resource'),
    url(r'^update-course-info/(?P<pk>\d+)/$', courseview.update_course_info, name='update_course_info'),

    url(r'^notifications/', include(notifications.urls, namespace='notifications')),

    url(r'api/dspace/communityarticlesapi', communityviewsets.CommunityArticleViewsets.as_view(), name='community-articles-dspace-api'),
    url(r'api/dspace/communityapi', communityviewsets.CommunityViewSet.as_view(), name='community-dspace-api'),

    url(r'api/dspace/grouparticlesapi', groupviewsets.GroupArticleViewsets.as_view(), name='group-articles-dspace-api'),
    url(r'api/dspace/groupapi', groupviewsets.GroupViewSet.as_view(), name='group-dspace-api'),
    url(r'^community-dashboard/(?P<pk>\d+)/$',dashboardview.community_dashboard,name='community_dashboard'),
    url(r'^article-dashboard/(?P<pk>\d+)/$',dashboardview.article_dashboard,name='article_dashboard'),
    url(r'^user-insight-dashboard/$',dashboardview.user_insight_dashboard,name='user_insight_dashboard'),


    url(r'api/course/', include('Course.api.urls', namespace = 'api-course')),
    url(r'logapi/', include('eventlog.api.urls', namespace="api-log")),
    url(r'recommendation_json_object/',views.get_Recommendations().as_view(),name='recommendation_json_object'),
    url(r'^community_media_create/(?P<pk>\d+)/(?P<mediatype>[\w\-]+)$', mediaview.MediaCreateView.as_view(), name='community_media_create'),

    url(r'media_view/(?P<pk>\d+)/$', mediaview.media_view, name='media_view'),
    url(r'^media_edit/(?P<pk>\d*)/$', mediaview.MediaUpdateView.as_view(), name='media_edit'),
    url(r'media_reports/(?P<pk>\d+)/$', mediaview.media_reports, name='media_reports'),

    url(r'^display_published_media/(?P<mediatype>[\w\-]+)/$', mediaview.display_published_media, name='display_published_media'),
    url(r'^upload_task/', taskview.upload_task, name='upload_task'),
    url(r'^run_task/', taskview.run_task, name='run_task'),

    url(r'manage_reputation/',repuationview.manage_reputation , name = 'manage_reputation'),
    url(r'manage_resource_score/',repuationview.manage_resource_score , name = 'manage_resource_score'),
    url(r'manage_role_score/',repuationview.manage_user_role_score , name = 'manage_role_score'),

    url(r'api/reputation/', include('Reputation.api.urls', namespace = 'api-reputation')),

    url(r'api/community/', include('Community.api.urls', namespace = 'api-community')),
    url(r'categorized_communities/(?P<catid>\d+)/(?P<commid>\d+)/$', categoryview.categorized_communities, name='categorized_communities'),
    url(r'categories/$', categoryview.categories, name='categories'),

]

from wiki.urls import get_pattern as get_wiki_pattern
from django_nyt.urls import get_pattern as get_nyt_pattern

urlpatterns += [
    url(r'^wiki-notifications/', get_nyt_pattern()),
    url(r'^wiki/', get_wiki_pattern())
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
