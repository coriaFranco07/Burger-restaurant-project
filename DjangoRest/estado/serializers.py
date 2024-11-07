from rest_framework import serializers
from .models import Estado

class EstadoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Estado
        fields = ('id_estado', 'tipo', 'created_at')
        read_only_fields = ('created_at', )