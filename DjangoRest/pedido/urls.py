from rest_framework import routers
from .api import PedidoViewSet

router = routers.DefaultRouter()

router.register('api/pedido', PedidoViewSet, 'pedido')


urlpatterns = router.urls