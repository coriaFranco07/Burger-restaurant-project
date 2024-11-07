from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import Cliente
from .serializers import ClienteSerializer

class ClienteViewSet(viewsets.ModelViewSet):
    queryset = Cliente.objects.all()
    serializer_class = ClienteSerializer
    permission_classes = [permissions.AllowAny]

    @action(detail=True, methods=['patch'])
    def change_password(self, request, pk=None):
        cliente = self.get_object()
        password = request.data.get('password')

        if not password:
            return Response({"error": "Password is required"}, status=status.HTTP_400_BAD_REQUEST)

        cliente.set_password(password)  # Usa set_password para cifrar la nueva contraseña
        cliente.save()

        return Response({"status": "Password updated successfully"}, status=status.HTTP_200_OK)