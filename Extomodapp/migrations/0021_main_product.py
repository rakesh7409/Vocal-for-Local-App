# Generated by Django 3.0.7 on 2020-07-02 20:47

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Extomodapp', '0020_delete_product_choices'),
    ]

    operations = [
        migrations.CreateModel(
            name='main_product',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('product_country', models.CharField(choices=[('1', 'Indian'), ('2', 'Foreign')], default='1', max_length=20)),
                ('Image_url', models.URLField()),
                ('desc', models.CharField(max_length=50, null=True)),
                ('category_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.category')),
                ('product_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.products')),
                ('subcategory_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.subcategory')),
            ],
        ),
    ]
