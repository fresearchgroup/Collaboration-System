from modeltranslation.translator import register, TranslationOptions
from Community.models import Community

@register(Community)
class CommunityTranslationOptions(TranslationOptions):
    fields = ('name', 'desc',)