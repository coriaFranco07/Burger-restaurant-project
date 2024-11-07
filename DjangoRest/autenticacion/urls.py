# urls.py

from django.urls import path
from .api import register, login 
from rest_framework import routers

router = routers.DefaultRouter()

urlpatterns = [
    path('api/register/', register, name='register'),
    path('api/login/', login, name='login'),
]

urlpatterns += router.urls
