# Generated by Django 5.0.6 on 2024-06-13 21:41

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('estado', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='estado',
            name='id_estado',
        ),
    ]