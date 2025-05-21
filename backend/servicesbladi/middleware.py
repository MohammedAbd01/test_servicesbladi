from django.contrib import messages
import time
import random
from django.utils.deprecation import MiddlewareMixin
from django.utils import timezone

class MessageMiddleware(MiddlewareMixin):
    """Middleware for processing message-related tasks"""

    def process_request(self, request):
        if request.user.is_authenticated:
            # Set last active timestamp
            if hasattr(request.user, 'last_active'):
                request.user.last_active = timezone.now()
                request.user.save(update_fields=['last_active'])

        return None

class CacheControlMiddleware(MiddlewareMixin):
    """Middleware to control browser caching of static files"""
    
    def process_request(self, request):
        # Generate a cache version based on the current timestamp if not already in session
        if 'cache_version' not in request.session:
            # Use timestamp plus a random number to ensure uniqueness
            cache_version = f"{int(time.time())}.{random.randint(1, 100)}"
            request.session['cache_version'] = cache_version
        return None
    
    def process_response(self, request, response):
        # Add cache control headers to prevent caching for HTML responses
        if response.get('Content-Type', '').startswith('text/html'):
            response['Cache-Control'] = 'no-cache, no-store, must-revalidate'
            response['Pragma'] = 'no-cache'
            response['Expires'] = '0'
        return response
