# Generated by Django 3.0.7 on 2020-06-30 19:38

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Extomodapp', '0009_auto_20200701_0106'),
    ]

    operations = [
        migrations.AlterField(
            model_name='productslevelone',
            name='Categories',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.category'),
        ),
    ]
