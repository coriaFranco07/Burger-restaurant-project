from .models import Comida
from rest_framework import viewsets, permissions
from .serializers import ComidaSerializer

class ComidaViewSet(viewsets.ModelViewSet):
    queryset = Comida.objects.all()
    permission_classes = [permissions.AllowAny]
    serializer_class = ComidaSerializer