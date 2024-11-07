from rest_framework import serializers
from .models import PedidoDetalle

class PedidoDetalleSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = PedidoDetalle
        fields = ['id_pedido_detalle', 'id_pedido', 'id_comida', 'cantidad_comida', 'total', 'id_estado', 'created_at']
