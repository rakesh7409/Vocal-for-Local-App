from rest_framework import serializers
from .models import *


class catonlySerializer(serializers.ModelSerializer):
    class Meta:
        model = category
        fields = ('__all__'
                  )


class imageSerializer(serializers.ModelSerializer):
    class Meta:
        model = category
        fields = ['Image_url']


class subcatSerializer(serializers.ModelSerializer):
    class Meta:
        model = subcategory
        fields = (
            '__all__'
        )


class productSerializer(serializers.ModelSerializer):
    class Meta:
        model = products
        fields = (
            '__all__'
        )


class sub(serializers.ModelSerializer):
    class Meta:
        model = subcategory
        fields = (
            '__all__'
        )


class submain(serializers.ModelSerializer):
    class Meta:
        model = main_product
        depth = 2

        fields = (
            '__all__'
        )


class mainbody(serializers.ModelSerializer):
    class Meta:
        model = main_product

        fields = [
            'Image_url', 'name','id'
        ]

class wishlistSerializer(serializers.ModelSerializer):
    class Meta:
        model= wishlist
        fields=('__all__')


class wishlistproducts(serializers.ModelSerializer):
    main_product = mainbody()
    class Meta:
        model=wishlist
        fields=['main_product']