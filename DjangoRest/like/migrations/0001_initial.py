# Generated by Django 5.0.6 on 2024-06-14 00:30

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('comida', '0001_initial'),
        ('estado', '0004_alter_estado_id_estado'),
        ('usuario', '0003_remove_cliente_is_active_remove_cliente_is_staff'),
    ]

    operations = [
        migrations.CreateModel(
            name='Like',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('id_cliente', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='usuario.cliente')),
                ('id_comida', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='comida.comida')),
                ('id_estado', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='estado.estado')),
            ],
        ),
    ]
