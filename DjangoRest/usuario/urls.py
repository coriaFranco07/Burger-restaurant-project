from rest_framework import routers
from .api import ClienteViewSet

router = routers.DefaultRouter()
router.register('api/cliente', ClienteViewSet, 'cliente')

urlpatterns = router.urls
