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
    }
