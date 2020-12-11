# Generated by Django 3.0.7 on 2020-07-02 21:02

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Extomodapp', '0021_main_product'),
    ]

    operations = [
        migrations.AlterField(
            model_name='main_product',
            name='category_id',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.category'),
        ),
        migrations.AlterField(
            model_name='main_product',
            name='desc',
            field=models.CharField(blank=True, max_length=50, null=True),
        ),
        migrations.AlterField(
            model_name='main_product',
            name='product_id',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.products'),
        ),
        migrations.AlterField(
            model_name='main_product',
            name='subcategory_id',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.subcategory'),
        ),
    ]