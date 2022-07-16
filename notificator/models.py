from django.db import models

class User(models.Model):
    email = models.CharField(max_length=60, blank=True, null=True)
    status = models.CharField(max_length=60, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    last_update = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return self.email

class Notification(models.Model):
    title = models.CharField(max_length=60, blank=True, null=True)
    body = models.CharField(max_length=60, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    last_update = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return self.title