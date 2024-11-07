from rest_framework import serializers
from .models import Comida

class ComidaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comida
        fields = ('id_comida', 'name', 'store', 'image', 'proximity', 'price', 'stock', 'starts', 'id_estado', 'created_at')
        read_only_fields = ('created_at', )