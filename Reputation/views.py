from django.shortcuts import render, redirect
from .models import ResourceScore, BadgeScore
# Create your views here.

def manage_reputation(request):
    if request.user.is_superuser:
        res=0
        scr=0
        if ResourceScore.objects.filter(resource_type='resource').exists():
            res = ResourceScore.objects.get(resource_type='resource')
        scr = BadgeScore.objects.get_or_create()[0]
        return render(request, 'manage_reputation.html', {'res':res, 'scr':scr})
    
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
            # pub_value = request.POST.get('pub_value')
            # author_value = request.POST.get('author_value')
            # if pub_value == '':
            #     pub_value = 0
            # if author_value == '':
            #     author_value = 0
            
            scr = BadgeScore.objects.get_or_create()[0]
            # scr.publisher = pub_value
            # scr.author = author_value

            scr.articles_contributed_level_1 = request.POST.get('ac_level1_val')
            scr.articles_contributed_level_2 = request.POST.get('ac_level2_val')
            scr.articles_contributed_level_3 = request.POST.get('ac_level3_val')
            scr.articles_contributed_level_4 = request.POST.get('ac_level4_val')
            scr.articles_contributed_level_5 = request.POST.get('ac_level5_val')
            scr.my_articles_published_level_1 = request.POST.get('ap_level1_val')
            scr.my_articles_published_level_2 = request.POST.get('ap_level2_val')
            scr.my_articles_published_level_3 = request.POST.get('ap_level3_val')
            scr.my_articles_published_level_4 = request.POST.get('ap_level4_val')
            scr.my_articles_published_level_5 = request.POST.get('ap_level5_val')
            scr.articles_revised_by_me_level_1 = request.POST.get('ra_level1_val')
            scr.articles_revised_by_me_level_2 = request.POST.get('ra_level2_val')
            scr.articles_revised_by_me_level_3 = request.POST.get('ra_level3_val')
            scr.articles_revised_by_me_level_4 = request.POST.get('ra_level4_val')
            scr.articles_revised_by_me_level_5 = request.POST.get('ra_level5_val')
            scr.articles_published_by_me_level_1 = request.POST.get('pa_level1_val')
            scr.articles_published_by_me_level_2 = request.POST.get('pa_level2_val')
            scr.articles_published_by_me_level_3 = request.POST.get('pa_level3_val')
            scr.articles_published_by_me_level_4 = request.POST.get('pa_level4_val')
            scr.articles_published_by_me_level_5 = request.POST.get('pa_level5_val')
            
            scr.save()
            return redirect('manage_reputation')
        else:
            return redirect('manage_reputation')
    else:
        return redirect('home')
