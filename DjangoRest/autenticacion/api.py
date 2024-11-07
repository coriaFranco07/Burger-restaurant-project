from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework import status
from usuario.models import Cliente, ClienteToken
from usuario.serializers import ClienteSerializer
from django.contrib.auth.hashers import make_password
from rest_framework_simplejwt.tokens import RefreshToken
from django.shortcuts import get_object_or_404

@api_view(['POST'])
@permission_classes([AllowAny])
def login(request):
    print("Entrando a función Login")
    print(request.data)

    username = request.data.get("username")
    password = request.data.get("password")

    # Verificar si el nombre de usuario existe en la base de datos
    cliente = get_object_or_404(Cliente, usuario=username)

    # Verificar si la contraseña proporcionada coincide con la contraseña del cliente
    if not cliente.check_password(password):
        return Response({"error": "Credenciales inválidas"}, status=status.HTTP_400_BAD_REQUEST)

    # Generar o recuperar el token para el cliente
    token, created = ClienteToken.objects.get_or_create(user=cliente)

    # Serializar los datos del cliente para incluir en la respuesta
    serializer = ClienteSerializer(instance=cliente)

    # Devolver el token y los datos del cliente en la respuesta
    return Response({"token": token.key, "user": serializer.data}, status=status.HTTP_200_OK)


def get_tokens_for_user(user):

    refresh = RefreshToken()
    refresh['id'] = user.id_cliente  # Use id_cliente as the identifier
    refresh.set_exp(lifetime=refresh.lifetime)  # Set token expiration if needed
    access_token = refresh.access_token

    return {
        'refresh': str(refresh),
        'access': str(access_token),
    }


@api_view(['POST'])
@permission_classes([AllowAny])
def register(request):

    print("Vista alcanzada")  # Verifica que la vista está siendo llamada
    print(request.data)  # Imprime los datos recibidos

    serializer = ClienteSerializer(data=request.data)

    if serializer.is_valid():
        validated_data = serializer.validated_data
        validated_data['contraseña'] = make_password(validated_data['contraseña'])
        user = Cliente.objects.create(**validated_data)

        # Generate tokens for the user
        tokens = get_tokens_for_user(user)

        return Response({"tokens": tokens, "user": serializer.data}, status=status.HTTP_201_CREATED)
    else:
        print(serializer.errors)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)





