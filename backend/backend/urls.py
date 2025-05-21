"""backend URL Configuration"""
from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings
from django.utils.translation import gettext_lazy as _

# Change admin site title
admin.site.site_header = _("MRE Administration")
admin.site.site_title = _("MRE Admin")
admin.site.index_title = _("Dashboard")

urlpatterns = [
    path('admin/', admin.site.urls),
    path('accounts/', include('accounts.urls', namespace='accounts')),
    path('requests/', include('custom_requests.urls', namespace='custom_requests')),
    path('services/', include('services.urls', namespace='services')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT) 