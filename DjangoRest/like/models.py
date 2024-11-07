from django.db import models
from comida.models import Comida
from usuario.models import Cliente
from estado.models import Estado   # Asegúrate de que el modelo Estado esté importado

class Like(models.Model):
    id_like = models.AutoField(primary_key=True)
    id_cliente = models.ForeignKey(Cliente, on_delete=models.SET_NULL, null=True, blank=True)
    id_comida = models.ForeignKey(Comida, on_delete=models.SET_NULL, null=True, blank=True)
    id_estado = models.ForeignKey(Estado, on_delete=models.SET_NULL, null=True, blank=True, default=8)  
    created_at = models.DateTimeField(auto_now_add=True) 

    def __str__(self):
            return f"Like {self.id_like} - Usuario: {self.id_cliente} - Comida: {self.id_comida}"
