# Generated by Django 5.0.6 on 2024-07-08 16:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('usuario', '0008_alter_cliente_nombre_completo_alter_cliente_num_tel'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cliente',
            name='nombre_completo',
            field=models.CharField(max_length=255),
        ),
        migrations.AlterField(
            model_name='cliente',
            name='num_tel',
            field=models.CharField(max_length=15),
        ),
    ]