import time
import datetime

from Community.models import CommunityArticles
from Group.models import GroupArticles

def get_community_info_from_article_info(data):
    args = data['view_kwargs']
    if 'pk' in list(args.keys()):
        article_id = args['pk']
    else:
        return ""
    objs = CommunityArticles.objects.filter(article=article_id)
    if len(objs) > 0:
        community_id = objs.first().community_id
        return community_id
    else:
        return ""

def get_group_info_from_article_info(data):
    args = data['view_kwargs']
    if 'pk' in list(args.keys()):
        article_id = args['pk']
    else:
        return ""
    objs = GroupArticles.objects.filter(article=article_id)
    if len(objs) > 0:
       group_id = objs.first().group_id
       return group_id
    else:
        return ""

def process_user_agent(data):
    request = data['request']
    remote_addr = request.META.get('HTTP_USER_AGENT')
    if remote_addr == None:
        return ""
    else:
        return remote_addr

def process_server_host(data):
    request = data['request']
    host = request.META.get('SERVER_NAME')
    if host == None:
        return ""
    else:
        return host

def process_referer(data):
    request = data['request']
    referer = request.META.get('HTTP_REFERER')
    if referer == None:
        return ""
    else:
        return referer

def process_accept_language(data):
    request = data['request']
    accept_language = request.META.get('HTTP_ACCEPT_LANGUAGE')
    if accept_language == None:
        return ""
    else:
        return accept_language

def process_session_id(data):
    request = data['request']
    if 'sessionid' in list(request.COOKIES.keys()):
        return request.COOKIES['sessionid']
    else:
        return ""

def process_host_ip(data):
    request = data['request']
    ip = request.META.get('REMOTE_ADDR')
    if ip == None:
        return ""
    else:
        return ip

def process_path_info(data):
    request = data['request']
    path_info = request.path_info
    if path_info == None:
        return ""
    else:
        return path_info

def process_method(data):
    request = data['request']
    return request.method

def process_user_info(data):
    request = data['request']
    if request.user.is_authenticated():
        return request.user.id
    else:
        return ""

def process_community_info(data):
    args = data['view_kwargs']
    if 'pk' in list(args.keys()):
        return args['pk']
    else:
        return ""

def process_group_info(data):
    args = data['view_kwargs']
    dic = {}
    if 'pk' in list(args.keys()):
        return args['pk']
    else:
        return ""

def process_article_info(data):
    args = data['view_kwargs']
    dic = {}
    if 'pk' in list(args.keys()):
        return args['pk']
    else:
        return ""

def process_time_stamp(data):
    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H:%M:%S")
    return st

def proces_attach_event_source(data):
    return 'server'

def process_article_state(data):
    request = data['request']
    try:
        state = request.POST.__getitem__("state")
        return state
    except KeyError:
        return ""

def process_cid(data):
    request = data['request']
    try:
        cid = request.POST.__getitem__('cid')
        return cid
    except KeyError:
        return ""

def process_gid(data):
    request = data['request']
    try:
        gid = request.POST.__getitem__('gid')
        return gid
    except KeyError:
        return ""

def process_username_from_request(data):
    request = data['request']
    try:
        username=request.POST.__getitem__('username')
        return username
    except KeyError:
        return ""


def  process_username_info(data):
    args = data['view_kwargs']
    if 'username' in list(args.keys()):
        return args['username']
    else:
        return ""

def process_coursename_info(data):
    request = data['request']
    try:
        coursename = request.POST.__getitem__('name')
        return coursename
    except:
        return ""

def process_course_info(data):
    args = data['view_kwargs']
    if 'pk' in list(args.keys()):
        return args['pk']
    else:
        return ""

def process_post_community_name(data):
    request = data['request']
    try:
        communityname = request.POST.__getitem__('name')
        return communityname
    except:
        return ""

def process_comment_reply_to(data):
    request = data['request']
    try:
        reply_to = request.POST.__getitem__('reply_to')
        return reply_to
    except:
        return ""

def process_comment_object_pk(data):
    request = data['request']
    try:
        objectpk = request.POST.__getitem__('object_pk')
        return objectpk
    except:
        return ""

def process_post_group_name(data):
    request = data['request']
    try:
        group_name = request.POST.__getitem__('name')
        return group_name
    except:
        return ""

def process_manage_group_role(data):
    request = data['request']
    try:
        role = request.POST.__getitem__('role')
        return role
    except:
        return ""

def process_manage_group_status(data):
    request = data['request']
    try:
        status = request.POST.__getitem__('status')
        return status
    except:
        return ""
