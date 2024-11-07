from django.contrib import admin
from .models import Estado

# Clase personalizada para administrar el modelo Estado en el panel de administración
class EstadoAdmin(admin.ModelAdmin):
    list_display = ('id_estado', 'tipo', 'created_at')  # Campos a mostrar en la lista de registros
    list_filter = ('created_at',)  # Filtros por fecha de creación

# Registro del modelo Estado utilizando la clase EstadoAdmin personalizada
admin.site.register(Estado, EstadoAdmin)