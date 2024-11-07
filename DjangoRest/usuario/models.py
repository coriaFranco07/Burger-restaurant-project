from django.db import models
from django.conf import settings
import binascii
import os
from django.contrib.auth.hashers import check_password, make_password
from rest_framework.authtoken.models import Token

class Cliente(models.Model):
    id_cliente = models.AutoField(primary_key=True)
    nombre_completo = models.CharField(max_length=255)
    usuario = models.CharField(max_length=50, unique=True)
    contraseña = models.CharField(max_length=255)
    num_tel = models.CharField(max_length=15)
    id_estado = models.ForeignKey('estado.Estado', on_delete=models.SET_NULL, null=True, blank=True, default=8)
    created_at = models.DateTimeField(auto_now_add=True)

    def set_password(self, raw_password):
        self.contraseña = make_password(raw_password)

    def check_password(self, raw_password):
        return check_password(raw_password, self.contraseña)

    def __str__(self):
        return self.usuario




class ClienteToken(models.Model):
    key = models.CharField(max_length=40, primary_key=True)
    user = models.OneToOneField(Cliente, related_name='auth_token', on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)

    def save(self, *args, **kwargs):
        if not self.key:
            self.key = self.generate_key()
        return super().save(*args, **kwargs)

    def generate_key(self):
        return binascii.hexlify(os.urandom(20)).decode()

    def __str__(self):
        return self.key
