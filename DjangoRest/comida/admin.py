from django.contrib import admin
from .models import Comida

@admin.register(Comida)
class ComidaAdmin(admin.ModelAdmin):
    list_display = ('name', 'store', 'price', 'stock', 'starts', 'id_estado', 'created_at')
    list_filter = ('id_estado', 'created_at')
    search_fields = ('name', 'store')
    ordering = ('created_at',)
