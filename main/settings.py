from . import logprocess

STORE = 1
TOSERVER = 2

LOG_TYPE = STORE

STORE_CONF = {
            "filename": "debug.log"
}

DEBUG = True

SERVER_CONF = {
        "protocol": "http",
        "address": "127.0.0.1",
        "port": 8090,
        "use_proxy": True,
        "proxies": {
            "http": "http://proxy.cse.iitb.ac.in:80",
            "https": "https://proxy.cse.iitb.ac.in:80",
            "ftp": "ftp://proxy.cse.iitb.ac.in:80",
        },
        "proxy_auth": {
            "username": "",
            "password": ""
            }
    }

COMMON_FIELDS = {
            "user-agent": logprocess.process_user_agent,
            "ip-addres": logprocess.process_host_ip,
            "server-host": logprocess.process_server_host,
            "referer": logprocess.process_referer,
            "accept-language": logprocess.process_accept_language,
            "session-id": logprocess.process_session_id,
            "path-info": logprocess.process_path_info,
            "time-stamp": logprocess.process_time_stamp,
            "event-source": logprocess.proces_attach_event_source,
            "user-id": logprocess.process_user_info,
}

CONTEXT_SPECIFIC_FIELDS = {

        #article specific events
        "event.article.create":{
            "article-id": logprocess.process_article_info,
            "community-id": logprocess.process_cid,
            "group-id": logprocess.process_gid
        },

        "event.article.view": {
            "article-id": logprocess.process_article_info,
        },
        "event.article.edit": {
            "article-id": logprocess.process_article_info,
        },
        "event.article.statusChanged": {
            "article-id": logprocess.process_article_info,
            "status": logprocess.process_article_state
        },
        "event.article.published": {
            "article-id": logprocess.process_article_info,
            "publisher-id": logprocess.process_user_info
        },
        "event.article.deleted": {
            "article-id": logprocess.process_article_info,
        },
        "event.article.reported": {
            "article-id": logprocess.process_article_info,
        },

        #community specific events
        "event.community.view": {
            "community-id": logprocess.process_community_info,
        },

        #community subscribe event
        "event.community.subscribe":{
            "community-id": logprocess.process_cid,
        },

        #community unsubscribe event
        "event.community.unsubscribe":{
            "community-id": logprocess.process_cid,
        },

        #login event
        "event.user.login":{
            "username": logprocess.process_username_from_request
        },

        #logout event
        "event.user.logout":{
             "user-id": logprocess.process_user_info
        },

        #profile view event
        "event.profile.view":{
             "user-visited": logprocess.process_username_info
        },

        #group view event
        "event.group.view":{
             "group-id": logprocess.process_group_info
        },

        #group unsubscibe event
        "event.group.unsubscribe":{
             "group-id": logprocess.process_gid
        },

        #community create event
        "event.community.create":{
            "community-name": logprocess.process_post_community_name,
            "admin-username":logprocess.process_username_from_request
        },

        #group create event
        "event.group.create":{
            "community-id": logprocess.process_cid,
            "group-name": logprocess.process_post_group_name
        },

        #group manage event
        "event.group.manage":{
            "invitation-username":logprocess.process_username_from_request,
            "role": logprocess.process_manage_group_role ,
            "status": logprocess.process_manage_group_status
        },


        #community content view event
        "event.content.view": {
            "community-id": logprocess.process_cid
        },

        #course create event
        "event.course.create": {
            "community-id": logprocess.process_cid,
            "course-name": logprocess.process_coursename_info
        },

        #course view event
        "event.course.view": {
            "course-id": logprocess.process_course_info
        },

        #course edit event
        "event.course.edit":{
            "user-id":logprocess.process_user_info
        },

        #course manage-resource event
        "event.course.manage":{
            "user-id":logprocess.process_user_info
        },

        #update course-info event
        "event.course.update":{
            "course-name": logprocess.process_coursename_info
        },

        #comment post event
        "event.comment.post":{
            "reply-to-user-id":logprocess.process_comment_reply_to,
            "object-pk":logprocess.process_comment_object_pk
        }

}
