
from django.urls import include, path
from rest_framework import routers
from .api import LikeViewSet

router = routers.DefaultRouter()
router.register('api/like', LikeViewSet, 'like')

urlpatterns = [
    path('', include(router.urls)),
    path('api/like/like_by_user/<int:id_cliente>/', LikeViewSet.as_view({'get': 'like_by_user'}), name='like-by-user'),
    path('api/like/like_comida/', LikeViewSet.as_view({'post': 'like_comida'}), name='like-comida'),
    path('api/like/dislike_comida/', LikeViewSet.as_view({'delete': 'dislike_comida'}), name='dislike-comida'),
]
