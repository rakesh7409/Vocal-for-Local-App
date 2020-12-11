from import_export import resources
from .models import main_product


class Mainesource(resources.ModelResource):
    class Meta:
        model = main_product
