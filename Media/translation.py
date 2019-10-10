from modeltranslation.translator import register, TranslationOptions
from Media.models import Media

@register(Media)
class MediaTranslationOptions(TranslationOptions):
    fields = ('title',)