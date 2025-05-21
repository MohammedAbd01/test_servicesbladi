def language_context(request):
    """
    Context processor that adds the current language code to the template context.
    This allows JavaScript to access the current language.
    """
    return {
        'LANGUAGE_CODE': request.LANGUAGE_CODE
    }

def notifications_context(request):
    """
    Context processor that adds unread notifications count and recent notifications
    to the template context for authenticated users.
    """
    if not request.user.is_authenticated:
        return {
            'unread_notifications_count': 0,
            'notifications': []
        }
    
    # Import here to avoid circular imports
    from custom_requests.models import Notification
    
    # Get unread notifications count
    unread_count = Notification.objects.filter(
        user=request.user,
        is_read=False
    ).count()
    
    # Get recent notifications (limit to 5)
    notifications = Notification.objects.filter(
        user=request.user
    ).order_by('-created_at')[:5]
    
    return {
        'unread_notifications_count': unread_count,
        'notifications': notifications
    }