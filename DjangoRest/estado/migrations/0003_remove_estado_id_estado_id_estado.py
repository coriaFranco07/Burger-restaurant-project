# Generated by Django 5.0.6 on 2024-06-13 23:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('estado', '0002_remove_estado_id_estado'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='estado',
            name='id',
        ),
        migrations.AddField(
            model_name='estado',
            name='id_estado',
            field=models.AutoField(default=1, primary_key=True, serialize=False),
        ),
    ]