from rest_framework import routers
from .api import ComidaViewSet

router = routers.DefaultRouter()

router.register('api/comida', ComidaViewSet, 'comida')


urlpatterns = router.urls