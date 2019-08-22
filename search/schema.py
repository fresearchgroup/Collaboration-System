from datetime import datetime
from elasticsearch_dsl import Document, Date, Integer, Keyword, Text


class CommunityIndex(Document):
    community_id = Integer()
    name = Text(analyzer='snowball', fields={'raw': Keyword()})
    desc = Text(analyzer='snowball')
    image = Text(analyzer='snowball')
    image_thumbnail = Text(analyzer='snowball')
    tag_line = Text(analyzer='snowball')
    created_at = Date()
    created_by = Text(analyzer='snowball', fields={'raw': Keyword()})
    parent = Text(analyzer='snowball', fields={'raw': Keyword()})

    class Index:
        name = 'collab'
        settings = {
          "number_of_shards": 2,
        }

    def save(self, ** kwargs):
        return super(CommunityIndex, self).save(** kwargs)


class ArticleIndex(Document):
    article_id = Integer()
    title = Text(analyzer='snowball', fields={'raw': Keyword()})
    body = Text(analyzer='snowball')
    image = Text(analyzer='snowball')
    created_at = Date()
    created_by = Text(analyzer='snowball', fields={'raw': Keyword()})
    published_on = Date()
    published_by = Text(analyzer='snowball', fields={'raw': Keyword()})
    views = Integer()

    class Index:
        name = 'collab'
        settings = {
          "number_of_shards": 2,
        }

    def save(self, ** kwargs):
        return super(ArticleIndex, self).save(** kwargs)