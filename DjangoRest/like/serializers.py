from rest_framework import serializers
from .models import Like

class LikeSerializer(serializers.ModelSerializer):

    class Meta:
        model = Like
        fields = ['id_like', 'id_cliente', 'id_comida', 'id_estado', 'created_at']
