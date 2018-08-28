from django.shortcuts import render, redirect
from .models import ResourceScore
# Create your views here.

def manage_reputation(request):
    if request.user.is_superuser:
        if ResourceScore.objects.filter(resource_type='resource').exists():
            res = ResourceScore.objects.get(resource_type='resource')
        return render(request, 'manage_reputation.html', {'res':res})
    else:
        return redirect('home')


def manage_resource_score(request):
    if request.user.is_superuser:
        if request.method == 'POST':
            can_vote = bool(request.POST.get('can_vote', False))
            upvote = request.POST.get('upvote')
            if upvote == '':
                upvote = 0
            downvote = request.POST.get('downvote')
            if downvote == '':
                downvote = 0
            can_report = bool(request.POST.get('can_report', False))
            pub_content = request.POST.get('pub_content')
            if pub_content == '':
                pub_content = 0
            if ResourceScore.objects.filter(resource_type='resource').exists():
                res = ResourceScore.objects.get(resource_type='resource')
                res.can_vote_unpublished = can_vote
                res.upvote_value = upvote
                res.downvote_value = downvote
                res.can_report = can_report
                res.publish_value = pub_content
                res.save()
            else:
                ResourceScore.objects.create(can_vote_unpublished=can_vote, upvote_value=upvote, downvote_value=downvote, can_report=can_report, publish_value=pub_content)
            return redirect('manage_reputation')
        else:
            return redirect('manage_reputation')
    else:
        return redirect('home')