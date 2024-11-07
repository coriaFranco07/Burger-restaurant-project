from django.contrib import admin
from like.models import Like 


class LikeAdmin(admin.ModelAdmin):
    list_display = ('id_like', 'id_cliente', 'id_comida', 'id_estado', 'created_at') 

admin.site.register(Like, LikeAdmin)