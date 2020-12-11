from django.contrib import admin
from import_export.admin import ImportExportModelAdmin
from .models import *
# Register your models here.

admin.site.register(subcategory)
admin.site.register(category)
admin.site.register(products)
admin.site.register(wishlist)

@admin.register(main_product)
class PersonAdmin(ImportExportModelAdmin):
    pass
