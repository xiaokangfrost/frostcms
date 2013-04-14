from pyramid.config import Configurator
from sqlalchemy import engine_from_config

from pyramid.renderers import JSONP
from pyramid.decorator import reify
from pyramid.request import Request
from pyramid.security import unauthenticated_userid
from pyramid.events import NewRequest
from pyramid.httpexceptions import HTTPForbidden
from pyramid.authorization import ACLAuthorizationPolicy
from pyramid.session import UnencryptedCookieSessionFactoryConfig
from .authentication import AuthenticationPolicy
from .security import groupfinder
from .models import initialize_sql,DBSession,User

class MainRequest(Request):
    @reify
    def user(self):
        id = unauthenticated_userid(self)
        if id:
            conn=DBSession()
            user=conn.query(User).get(id)
            return user
        else:
            return None

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    engine = engine_from_config(settings, 'sqlalchemy.')
    initialize_sql(engine)
    authentication_policy = AuthenticationPolicy(
        settings['auth.secret'], cookie_name='frostcms', callback = groupfinder)
    authorization_policy = ACLAuthorizationPolicy() 
    my_session_factory = UnencryptedCookieSessionFactoryConfig('1@3$msT')
    config = Configurator(settings=settings,
                          root_factory='frostcms.security.RootFactory',
                          authentication_policy=authentication_policy,
                          authorization_policy=authorization_policy,
                          session_factory = my_session_factory,
                          request_factory=MainRequest)
    config.add_static_view('static', 'frostcms:static', cache_max_age=3600)
    config.add_static_view('upload', 'frostcms:upload')
    config.include("frostcms.views")
   # config.include("frostccms.admin")
    return config.make_wsgi_app()
