# Generated by Django 3.0.7 on 2020-07-01 12:49

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Extomodapp', '0016_auto_20200701_1815'),
    ]

    operations = [
        migrations.RenameField(
            model_name='products',
            old_name='subcategory_name',
            new_name='subcategory_id',
        ),
    ]
