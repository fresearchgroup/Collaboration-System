from rolepermissions.roles import AbstractUserRole

class Author(AbstractUserRole):
    available_permissions = {
        'create_article': True,
        'edit_article':True,
    }

class Publisher(AbstractUserRole):
    available_permissions = {
        'create_article': True,
        'edit_article':True,
        'publish_article':True,
        'delete_article':True,
    }

class CommunityAdmin(AbstractUserRole):
    available_permissions = {
        'create_article': True,
        'edit_article':True,
        'publish_article':True,
        'delete_article':True,
        'add_community_roles':True,
        'delete_community_roles':True,
    }

class GroupAdmin(AbstractUserRole):
    available_permissions = {
        'create_article': True,
        'edit_article':True,
        'publish_article':True,
        'delete_article':True,
    }