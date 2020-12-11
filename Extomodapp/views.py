from django.shortcuts import render
from .models import *
from .serializer import *
from rest_framework import generics, pagination
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.decorators import permission_classes
from rest_framework.permissions import IsAuthenticated
from django.shortcuts import get_object_or_404
# Create your views here.


# class categorywe(generics.RetrieveAPIView):

#serializer_class = catSerializer
# lookup_field = 'Categories'
#queryset = categorytree.objects.filter(Categories=lookup_field)


class categoryonly(generics.ListAPIView):
    queryset = category.objects.all()
    serializer_class = catonlySerializer
    passed_id = None


class subcat(generics.ListAPIView):
    queryset = subcategory.objects.all()
    serializer_class = subcatSerializer
    passed_id = None


class sub(generics.ListAPIView):
    serializer_class = subcatSerializer

    def get_queryset(self):
        username = self.kwargs['category_id']
        return subcategory.objects.filter(category_id=username)


class productsview(generics.ListAPIView):
    serializer_class = productSerializer

    def get_queryset(self):
        username = self.kwargs['subcategory_id']
        return products.objects.filter(subcategory_id=username)


class url_image(generics.ListAPIView):
    serializer_class = imageSerializer

    def get_queryset(self):
        username = self.kwargs['subcategory_id']
        return category.objects.filter(id=username)


class catimage(generics.ListAPIView):
    serializer_class = submain

    def get_queryset(self):
        username = self.kwargs['category_id']
        user = self.kwargs['product_country']
        return main_product.objects.filter(product_id=username, product_country=user)


class Mypage(pagination.PageNumberPagination):
    page_size = 8


class mainbody(generics.ListAPIView):
    serializer_class = mainbody
    pagination_class = Mypage

    def get_queryset(self):
        user = self.kwargs['product_country']
        return main_product.objects.filter(product_country=user)


# class allcat(generics.ListAPIView):
 #   queryset = categorytree.objects.all()
  #  serializer_class = catSerializer

@api_view(['GET', 'POST'])
def Search(request):
    try:
        search = request.data['search']
        data= main_product.objects.filter(name=search)
        if data:
            serializer = submain(data, many=True)
            return Response(serializer.data)
        else:
            return Response("No results found")
    except:
        return Response("Invalid data")




@api_view(['POST',])
@permission_classes((IsAuthenticated,))
def wishlist_create(request, pk):
    wish = wishlist()
    wish.user = request.user 
    if request.method == 'POST':
        serializer = wishlistSerializer(wish, data=request.data)
        if serializer.is_valid():
            serializer.save()
        product = get_object_or_404(main_product, pk=pk)
        user = request.user
    if wishlist.objects.filter(user=request.user, main_product=product).exists() :
        temp = wishlist.objects.filter(user=request.user, main_product=product)
        temp.delete()
        return Response(
            {
                "message":"Removed from wishlist",
                "status" : False,

                }
        )
    else :
        wishlist.objects.create(main_product=product, user=user)
        return Response(
            {
                "message":"Added to wishlist",
                "status" : True,
                }
        )

@api_view(['GET',])
@permission_classes((IsAuthenticated,))
def wishlist_view(request):
    
    try:
        items = wishlist.objects.filter(user=request.user)
    except items.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    if request.method == 'GET':
        serializer= wishlistproducts(items,many=True)
        return Response(serializer.data)
