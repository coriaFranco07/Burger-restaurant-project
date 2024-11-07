from django.db import models
from usuario.models import Cliente  # Ajusta la importación según tu estructura
from estado.models import Estado  # Ajusta la importación según tu estructura

class Pedido(models.Model):
    id_pedido = models.AutoField(primary_key=True)
    id_cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE, related_name='pedidos')
    id_estado = models.ForeignKey(Estado, on_delete=models.CASCADE) 
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Pedido {self.id_pedido} - cliente: {self.id_cliente.nombre_completo} - Estado: {self.id_estado.tipo}"
