from django.contrib import admin
from django.contrib.admin.helpers import ActionForm
from notificator.models import User, Notification
from django import forms

# CUSTOM FORMS
class UserFormAction(ActionForm):
    notification = forms.ModelChoiceField(queryset=Notification.objects.all(), required=False)

class UserAdmin(admin.ModelAdmin):
    ordering = ('created_at',)
    list_display = ('email', 'status', 'created_at', 'last_update', )
    search_fields = ('type', 'name', 'created_at', 'last_update', )

    # ACTIONS
    action_form = UserFormAction
    actions = ['send_notification']

    @admin.action(description='Send notification')
    def send_notification(modeladmin, request, queryset):
        # SEND NOTIFICATION
        pass

admin.site.register(User, UserAdmin)

class NotificationAdmin(admin.ModelAdmin):
    ordering = ('created_at',)
    list_display = ('title', 'created_at', 'last_update', )
    search_fields = ('title', 'created_at', 'last_update', )

admin.site.register(Notification, NotificationAdmin)
