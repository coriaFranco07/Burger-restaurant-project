# Generated by Django 5.0.6 on 2024-06-14 17:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('usuario', '0003_remove_cliente_is_active_remove_cliente_is_staff'),
    ]

    operations = [
        migrations.AddField(
            model_name='cliente',
            name='contraseña',
            field=models.CharField(default='valor_por_defecto', max_length=255),
        ),
    ]
