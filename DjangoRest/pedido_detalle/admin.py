from django.contrib import admin
from pedido_detalle.models import PedidoDetalle

class PedidoDetalleAdmin(admin.ModelAdmin):
    list_display = ('id_pedido_detalle', 'id_pedido', 'id_comida', 'cantidad_comida', 'total', 'id_estado', 'created_at')  

admin.site.register(PedidoDetalle, PedidoDetalleAdmin)