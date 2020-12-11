# Generated by Django 3.0.7 on 2020-07-01 22:23

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Extomodapp', '0017_auto_20200701_1819'),
    ]

    operations = [
        migrations.AddField(
            model_name='category',
            name='Image_url',
            field=models.URLField(null=True),
        ),
        migrations.CreateModel(
            name='product_choices',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('main_product_name', models.CharField(max_length=50)),
                ('product_country', models.CharField(choices=[('1', 'Indian'), ('2', 'Foreign')], default='1', max_length=20)),
                ('Image_url', models.URLField()),
                ('prouct_desc', models.CharField(max_length=50)),
                ('category_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.category')),
                ('product_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.products')),
                ('subcategory_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.subcategory')),
            ],
        ),
    ]
