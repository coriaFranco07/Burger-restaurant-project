# Generated by Django 5.0.6 on 2024-07-12 16:42

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('estado', '0004_alter_estado_id_estado'),
        ('usuario', '0013_clientetoken'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cliente',
            name='id_estado',
            field=models.ForeignKey(blank=True, default=8, null=True, on_delete=django.db.models.deletion.SET_NULL, to='estado.estado'),
        ),
    ]
