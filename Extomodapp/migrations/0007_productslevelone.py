# Generated by Django 3.0.7 on 2020-06-30 19:03

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Extomodapp', '0006_auto_20200630_0234'),
    ]

    operations = [
        migrations.CreateModel(
            name='Productslevelone',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('Category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='Extomodapp.category')),
            ],
        ),
    ]
