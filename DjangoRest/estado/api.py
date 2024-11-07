from .models import Estado
from rest_framework import viewsets, permissions
from .serializers import EstadoSerializer

class EstadoViewSet(viewsets.ModelViewSet):
    queryset = Estado.objects.all()
    permission_classes = [permissions.AllowAny]
    serializer_class = EstadoSerializer