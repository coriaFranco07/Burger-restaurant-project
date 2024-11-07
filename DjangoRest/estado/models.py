from django.db import models

class Estado(models.Model):
    id_estado = models.AutoField(primary_key=True)
    tipo = models.CharField(max_length=200)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.tipo
