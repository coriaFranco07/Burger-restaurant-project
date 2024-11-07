from rest_framework import serializers
from .models import Cliente

class ClienteSerializer(serializers.ModelSerializer):
    contraseña = serializers.CharField(write_only=True)

    class Meta:
        model = Cliente
        fields = ['id_cliente', 'nombre_completo', 'usuario', 'contraseña', 'num_tel', 'id_estado', 'created_at']

    def create(self, validated_data):
        cliente = Cliente(
            usuario=validated_data['usuario'],
            nombre_completo=validated_data['nombre_completo'],
            num_tel=validated_data['num_tel'],
            id_estado=validated_data['id_estado']
        )
        cliente.set_password(validated_data['contraseña'])
        cliente.save()
        return cliente

    def update(self, instance, validated_data):
        if 'contraseña' in validated_data:
            instance.set_password(validated_data['contraseña'])
            instance.save()
        return instance