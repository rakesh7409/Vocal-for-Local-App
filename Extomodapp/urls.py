from django.urls import path, include
from django.conf.urls import url
from .views import *

urlpatterns = [
    url(r'only/', categoryonly.as_view()),
    url(r'all/', subcat.as_view()),
    url('^sub/(?P<category_id>.+)/$', sub.as_view()),
    url('^product/(?P<subcategory_id>.+)/$', productsview.as_view()),
    url('^image/(?P<subcategory_id>.+)/$', url_image.as_view()),
    url('^subimage/(?P<category_id>.+)/(?P<product_country>.+)/$', catimage.as_view()),
    url('^mainbody/(?P<product_country>.+)/$', mainbody.as_view()),
    url('^search' , Search , name="search"),
    url('^wishlist/(?P<pk>.+)/$',wishlist_create, name="wishlist_add"), #here pk refers to the product_id
    url('^wishlist/view',wishlist_view, name="wishlist_view" ) #this displays all the product_id of the products in the wishlist of the user

]
