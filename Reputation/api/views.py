from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import generics
from .serializers import CommunityReputaionSerializer, ArticleScoreLogSerializaer, ArticleVotedByLogsSerializer
from Reputation.models import CommunityReputaion, ArticleScoreLog, ResourceScore, ArticleVotedByLogs
from rest_framework.permissions import IsAuthenticated
from Community.models import Community, CommunityMembership, CommunityArticles, CommunityGroups
from Group.models import GroupArticles
from django.http import Http404
from django.db.models import F
import json

class FetchCommunityReputation(generics.RetrieveUpdateDestroyAPIView):
    lookup_field = 'pk'
    serializer_class = CommunityReputaionSerializer
    permission_classes = (IsAuthenticated,)

    def get_object(self):
        cid = self.kwargs['pk']
        community = Community.objects.get(id=cid)
        if CommunityMembership.objects.filter(community=community, user=self.request.user).exists():
            if CommunityReputaion.objects.filter(community=community, user=self.request.user).exists():
                return CommunityReputaion.objects.get(community=community, user=self.request.user)
            else:
                return CommunityReputaion.objects.create(community=community, user=self.request.user)


@api_view(['POST'])
def ArticlePublishScore(request):
    articleid = reqxuest.data['pk']
    article = ArticleScoreLog.objects.get(article=articleid)

    if not article.publish and article.article.state.name == 'publish':
        res = ResourceScore.objects.get(resource_type='resource')
        if CommunityArticles.objects.filter(article=article.article).exists():
            comm_article = CommunityArticles.objects.get(
                article=article.article)
            repu = CommunityReputaion.objects.get(
                community=comm_article.community, user=article.article.created_by)
            repu.score += res.publish_value
            repu.save()
            repu = CommunityReputaionSerializer(repu, many=False)
            return Response(repu.data)
        else:
            group_article = GroupArticles.objects.get(artcile=article.article)
            comm_group = CommunityGroups.objects.get(group=group_article.group)
            repu = CommunityReputaion.objects.get(
                community=comm_group.community, user=article.article.created_by)
            repu.score += res.publish_value
            repu.save()
            repu = CommunityReputaionSerializer(repu, many=False)
            return Response(repu.data)


class ReputationStats(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated,)

    queryset = ArticleScoreLog.objects.all()
    serializer_class = ArticleScoreLogSerializaer


class ReputationStatsDetails(APIView):
    permission_classes = (IsAuthenticated,)

    def get_object(self, pk):
        try:
            return ArticleScoreLog.objects.get(pk=pk)
        except ArticleScoreLog.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        article_score_log = self.get_object(pk)
        article_user_log = ArticleVotedByLogs.objects.get(
            user=request.user,
            article=article_score_log.article
        )
        serializer = ArticleVotedByLogsSerializer(article_user_log)
        return Response(serializer.data)

    def post(self, request, pk, format=None):
        article_score_log = self.get_object(pk)

        updates = {
            'upvote': request.data.get('update_type') == 'upvote',
            'downvote': request.data.get('update_type') == 'downvote',
            'reported': request.data.get('update_type') == 'reported'
        }

        article_user_log, created = ArticleVotedByLogs.objects.get_or_create(
            user=request.user,
            article=article_score_log.article
        )

        if (updates['upvote']):
            if (not article_user_log.upvoted):
                article_score_log.upvote = F('upvote') + 1
                article_user_log.upvoted = True

                if (article_user_log.downvoted):
                    article_user_log.downvoted = False
                    article_score_log.downvote = F('downvote') - 1
            else:
                article_user_log.upvoted = False
                article_score_log.upvote = F('upvote') - 1

        if (updates['downvote']):
            if (not article_user_log.downvoted):
                article_score_log.downvote = F('downvote') + 1
                article_user_log.downvoted = True

                if (article_user_log.upvoted):
                    article_user_log.upvoted = False
                    article_score_log.upvote = F('upvote') - 1
            else:
                article_user_log.downvoted = False
                article_score_log.downvote = F('downvote') - 1

        if (updates['reported']):
            if (not article_user_log.reported):
                article_score_log.reported = F('reported') + 1
                article_user_log.reported = True
            else:
                article_user_log.reported = False
                article_score_log.reported = F('reported') - 1

        article_user_log.save()
        article_user_log.refresh_from_db()

        article_score_log.save()
        article_score_log.refresh_from_db()

        serializer = ArticleVotedByLogsSerializer(article_user_log)
        return Response(serializer.data)
