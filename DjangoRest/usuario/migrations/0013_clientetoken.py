# Generated by Django 5.0.6 on 2024-07-08 23:42

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('usuario', '0012_alter_cliente_id_estado'),
    ]

    operations = [
        migrations.CreateModel(
            name='ClienteToken',
            fields=[
                ('key', models.CharField(max_length=40, primary_key=True, serialize=False)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='auth_token', to='usuario.cliente')),
            ],
        ),
    ]
