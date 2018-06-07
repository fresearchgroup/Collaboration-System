from django.urls import path
from . import views

urlpatterns = [
        path('user/<int:id>/', views.get_user_id),
        path('event/<slug:param1>/<slug:param2>/', views.get_event),
        path('event/<slug:param1>/<slug:param2>)/<slug:eid>/', views.get_event_id),
        path('user/<int:id>/event/<slug:param1>/<slug:param2>/', views.get_user_id_event),
        path('user/<int:id>/event/<slug:param1>/<slug:param2>/<int:eid>/',views.get_user_id_event_id),
        ]
