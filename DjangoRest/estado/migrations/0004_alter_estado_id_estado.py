# Generated by Django 5.0.6 on 2024-06-13 23:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('estado', '0003_remove_estado_id_estado_id_estado'),
    ]

    operations = [
        migrations.AlterField(
            model_name='estado',
            name='id_estado',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
    ]
