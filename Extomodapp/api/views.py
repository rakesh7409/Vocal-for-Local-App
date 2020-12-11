from django.shortcuts import render
from Extomodapp.models import categorytree
from .serializer import catSerializer 
from rest_framework import generics
# Create your views here.


class category(generics.RetrieveAPIView):
    queryset = categorytree.objects.all()
    serializer_class = catSerializer
    lookup_field = 'Categories'
