from modeltranslation.translator import register, TranslationOptions
from BasicArticle.models import Articles

@register(Articles)
class ArticlesTranslationOptions(TranslationOptions):
    fields = ('title', 'body',)