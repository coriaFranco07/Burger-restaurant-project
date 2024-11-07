from django.db import models
from comida.models import Comida  # Ajusta la importación según tu estructura
from pedido.models import Pedido  # Ajusta la importación según tu estructura
from estado.models import Estado  # Ajusta la importación según tu estructura

class PedidoDetalle(models.Model):
    id_pedido_detalle = models.AutoField(primary_key=True)
    id_pedido = models.ForeignKey(Pedido, on_delete=models.CASCADE, related_name='detalles')
    id_comida = models.ForeignKey(Comida, on_delete=models.CASCADE)
    cantidad_comida = models.IntegerField()
    total = models.DecimalField(max_digits=8, decimal_places=2, blank=True, null=True)
    id_estado = models.ForeignKey(Estado, on_delete=models.SET_NULL, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def save(self, *args, **kwargs):
        if not self.total:
            self.total = self.id_comida.price * self.cantidad_comida
        super().save(*args, **kwargs)

    def __str__(self):
        return f"PedidoDetalle {self.id_pedido_detalle} - Pedido: {self.id_pedido.id_pedido} - Comida: {self.id_comida.name} - Cant: {self.cantidad_comida} - Total: {self.total}"
