from .models import PedidoDetalle
from rest_framework import viewsets, permissions
from .serializers import PedidoDetalleSerializer

class PedidoDetalleViewSet(viewsets.ModelViewSet):
    queryset = PedidoDetalle.objects.all()
    permission_classes = [permissions.AllowAny]
    serializer_class = PedidoDetalleSerializer