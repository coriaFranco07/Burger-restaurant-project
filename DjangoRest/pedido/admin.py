from django.contrib import admin
from pedido.models import Pedido 

class PedidoAdmin(admin.ModelAdmin):
    list_display = ('id_pedido', 'id_cliente', 'id_estado', 'created_at')  

admin.site.register(Pedido, PedidoAdmin)