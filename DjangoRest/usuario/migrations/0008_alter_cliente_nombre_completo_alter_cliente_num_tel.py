# Generated by Django 5.0.6 on 2024-07-08 16:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('usuario', '0007_remove_cliente_contraseña'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cliente',
            name='nombre_completo',
            field=models.CharField(blank=True, max_length=255),
        ),
        migrations.AlterField(
            model_name='cliente',
            name='num_tel',
            field=models.CharField(blank=True, max_length=15),
        ),
    ]
