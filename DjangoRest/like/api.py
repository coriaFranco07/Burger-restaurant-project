from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from .models import Like
from .serializers import LikeSerializer
from comida.models import Comida  # Asegúrate de importar el modelo Comida si no está ya importado
from usuario.models import Cliente  # Importa el modelo Cliente si no está ya importado

class LikeViewSet(viewsets.ModelViewSet):
    queryset = Like.objects.all()
    serializer_class = LikeSerializer
    permission_classes = [permissions.AllowAny]  # Permitir acceso sin autenticación

    
    def like_by_user(self, request, id_cliente=None):
        likes = Like.objects.filter(id_cliente=id_cliente)
        serializer = self.serializer_class(likes, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)



    @action(detail=False, methods=['POST'], permission_classes=[permissions.AllowAny])
    def like_comida(self, request):
        id_comida = request.data.get('id_comida')
        id_cliente = request.data.get('id_cliente')
        #id_estado = request.data.get('id_estado')
        
        # Asegúrate de usar el nombre correcto del campo 'id_comida' y 'id_cliente'
        comida = get_object_or_404(Comida, id_comida=id_comida)
        cliente = get_object_or_404(Cliente, id_cliente=id_cliente)

        like, created = Like.objects.get_or_create(id_comida=comida, id_cliente=cliente)
        if not created:
            return Response({"message": "Ya te gusta esta comida"}, status=status.HTTP_200_OK)

        return Response({"message": "Comida añadida a favoritos"}, status=status.HTTP_201_CREATED)
    


    @action(detail=False, methods=['DELETE'], permission_classes=[permissions.AllowAny])
    def dislike_comida(self, request):
        id_comida = request.data.get('id_comida')
        id_cliente = request.data.get('id_cliente')
        
        # Asegúrate de usar el nombre correcto del campo 'id_comida' y 'id_cliente'
        comida = get_object_or_404(Comida, id_comida=id_comida)
        cliente = get_object_or_404(Cliente, id_cliente=id_cliente)

        like = Like.objects.filter(id_comida=comida, id_cliente=cliente).first()
        if like:
            like.delete()
            return Response({"message": "Comida eliminada de favoritos"}, status=status.HTTP_200_OK)

        return Response({"message": "No se encontró la comida en tus favoritos"}, status=status.HTTP_404_NOT_FOUND)
