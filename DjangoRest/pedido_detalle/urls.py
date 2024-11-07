from rest_framework import routers
from .api import PedidoDetalleViewSet

router = routers.DefaultRouter()

router.register('api/pedido_detalle', PedidoDetalleViewSet, 'pedido_detalle')

urlpatterns = router.urls