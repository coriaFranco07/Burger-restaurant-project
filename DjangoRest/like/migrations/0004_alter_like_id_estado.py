# Generated by Django 5.0.6 on 2024-07-17 14:29

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('estado', '0004_alter_estado_id_estado'),
        ('like', '0003_alter_like_id_like'),
    ]

    operations = [
        migrations.AlterField(
            model_name='like',
            name='id_estado',
            field=models.ForeignKey(blank=True, default=8, null=True, on_delete=django.db.models.deletion.SET_NULL, to='estado.estado'),
        ),
    ]
