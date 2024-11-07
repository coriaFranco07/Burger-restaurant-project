from rest_framework import serializers
from .models import Pedido

class PedidoSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Pedido
        fields = ['id_pedido', 'id_cliente', 'id_estado', 'created_at']
