from django.db import models
from estado.models import Estado  # Asegúrate de que el modelo Estado esté importado

class Comida(models.Model):
    id_comida = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)  # Nombre de la comida
    store = models.TextField()  # Descripción de la comida
    image = models.ImageField(upload_to='comida_images/', blank=True, null=True)  # Imagen de la comida
    proximity = models.IntegerField()  # Tiempo de proximidad en minutos
    price = models.DecimalField(max_digits=15, decimal_places=2)  # Precio de la comida
    stock = models.IntegerField()  # Cantidad en stock
    starts = models.FloatField()  # Valoración (estrellas)
    id_estado = models.ForeignKey(Estado, on_delete=models.SET_NULL, null=True, blank=True)  # Estado de la comida
    created_at = models.DateTimeField(auto_now_add=True)  # Fecha de creación

    def __str__(self):
        return self.name
