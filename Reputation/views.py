from django.shortcuts import render, redirect
from .models import ResourceScore, UserScore
# Create your views here.

def manage_reputation(request):
    if request.user.is_superuser:
        res=0
        scr=0
        if ResourceScore.objects.filter(resource_type='resource').exists():
            res = ResourceScore.objects.get(resource_type='resource')
        if UserScore.objects.filter(role_score='role_score').exists():
            scr = UserScore.objects.get(role_score='role_score')
        return render(request, 'manage_reputation.html', {'res':res, 'scr':scr})
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


def manage_user_role_score(request):
    if request.user.is_superuser:
        if request.method == 'POST':
            pub_value = request.POST.get('pub_value')
            if pub_value == '':
                pub_value = 0
            if UserScore.objects.filter(role_score='role_score').exists():
                scr = UserScore.objects.get(role_score='role_score')
                scr.publisher = pub_value
                scr.save()
            else:
                UserScore.objects.create(publisher=pub_value)
            return redirect('manage_reputation')
        else:
            return redirect('manage_reputation')
    else:
        return redirect('home')