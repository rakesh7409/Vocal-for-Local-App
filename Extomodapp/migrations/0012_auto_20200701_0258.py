# Generated by Django 3.0.7 on 2020-06-30 21:28

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Extomodapp', '0011_auto_20200701_0221'),
    ]

    operations = [
        migrations.RenameField(
            model_name='category',
            old_name='Categories',
            new_name='category_name',
        ),
        migrations.AlterField(
            model_name='subcategory',
            name='Categories',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.category'),
        ),
    ]
