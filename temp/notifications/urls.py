''' Django notification urls file '''
# -*- coding: utf-8 -*-
from distutils.version import StrictVersion  # pylint: disable=no-name-in-module,import-error

from django import get_version
from django.contrib.auth import views as auth_views

from . import views

if StrictVersion(get_version()) >= StrictVersion('2.0'):
    from django.urls import path
    urlpatterns = [
        path('', views.AllNotificationsList.as_view(), name='all'),
        path('unread/', views.UnreadNotificationsList.as_view(), name='unread'),
        path('mark-all-as-read/', views.mark_all_as_read, name='mark_all_as_read'),
        path('mark-as-read/<slug:slug>/', views.mark_as_read, name='mark_as_read'),
        path('mark-as-unread/<slug:slug>/', views.mark_as_unread, name='mark_as_unread'),
        path('mark-as-read-and-redirect/<slug:slug>/', views.mark_as_read_and_redirect, name='mark_as_read_and_redirect'),
        path('delete/<slug:slug>/', views.delete, name='delete'),
        path('api/unread_count/', views.live_unread_notification_count, name='live_unread_notification_count'),
        path('api/unread_list/', views.live_unread_notification_list, name='live_unread_notification_list'),
    ]
else:
    from django.conf.urls import url
    urlpatterns = [
        url(r'^$', views.AllNotificationsList.as_view(), name='all'),
        url(r'^unread/$', views.UnreadNotificationsList.as_view(), name='unread'),
        url(r'^mark-all-as-read/$', views.mark_all_as_read, name='mark_all_as_read'),
        url(r'^mark-all-as-unread/$', views.mark_all_as_unread, name='mark_all_as_unread'),
        url(r'^mark-all-as-deleted/$', views.mark_all_as_deleted, name='mark_all_as_deleted'),
        url(r'^mark-all-read-as-deleted/$', views.mark_all_read_as_deleted, name='mark_all_read_as_deleted'),
        url(r'^mark-all-unread-as-deleted/$', views.mark_all_unread_as_deleted, name='mark_all_unread_as_deleted'),
        url(r'^mark-as-read/(?P<slug>\d+)/$', views.mark_as_read, name='mark_as_read'),
        url(r'^mark-as-unread/(?P<slug>\d+)/$', views.mark_as_unread, name='mark_as_unread'),
        url(r'^mark-as-read-and-redirect/(?P<slug>\d+)/$', views.mark_as_read_and_redirect,
            name='mark_as_read_and_redirect'),
        url(r'^delete/(?P<slug>\d+)/$', views.delete, name='delete'),
        url(r'^api/unread_count/$', views.live_unread_notification_count, name='live_unread_notification_count'),
        url(r'^api/unread_list/$', views.live_unread_notification_list, name='live_unread_notification_list'),

        # Redirecting un-authorised users to login page
        url(r'^login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^unread/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^mark-all-as-read/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^mark-all-as-deleted/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^mark-all-read-as-deleted/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^mark-all-unread-as-deleted/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^mark-all-as-unread/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^mark-as-read/(?P<slug>\d+)/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^mark-as-unread/(?P<slug>\d+)/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^mark-as-read-and-redirect/(?P<slug>\d+)/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^delete/(?P<slug>\d+)/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^api/unread_count/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
        url(r'^api/unread_list/login/$', auth_views.LoginView.as_view(template_name='login.html', redirect_authenticated_user=True)),
    ]

app_name = 'notifications'