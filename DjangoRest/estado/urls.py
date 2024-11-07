from rest_framework import routers
from .api import EstadoViewSet

router = routers.DefaultRouter()

router.register('api/estado', EstadoViewSet, 'estado')


urlpatterns = router.urls