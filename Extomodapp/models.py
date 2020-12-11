from django.db import models
from django.conf import settings
from django.contrib.auth import get_user_model
# Create your models here.

User = get_user_model()

class category(models.Model):
    category_name = models.CharField(max_length=50)
    Image_url = models.URLField(max_length=200, null=True)

    def __str__(self):
        return self.category_name


class subcategory(models.Model):
    subcategory_name = models.CharField(max_length=50)
    category_id = models.ForeignKey(category, on_delete=models.CASCADE)

    def __str__(self):
        return self.subcategory_name


class products(models.Model):
    product_name = models.CharField(max_length=50)
    category_id = models.ForeignKey(category, on_delete=models.CASCADE)
    subcategory_id = models.ForeignKey(subcategory, on_delete=models.CASCADE)

    def __str__(self):
        return self.product_name


PRODUCT_CHOICES = (
    ("1", "Indian"),
    ("2", "Foreign"),
)

# declaring a Student Model


class main_product(models.Model):
    name = models.CharField(max_length=50, null=True, blank=True)
    product_country = models.CharField(
        max_length=20,
        choices=PRODUCT_CHOICES,
        default='1'
    )
    Image_url = models.URLField(max_length=200)
    product_id = models.ForeignKey(
        products, on_delete=models.CASCADE, blank=True, null=True)
    desc = models.CharField(max_length=50, blank=True, null=True)

    def __str__(self):
        return self.name


class wishlist(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    main_product = models.ForeignKey(main_product , on_delete=models.CASCADE)