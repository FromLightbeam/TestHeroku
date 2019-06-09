from django.contrib import admin
from django.urls import path

from rest_framework_jwt.views import obtain_jwt_token, refresh_jwt_token, verify_jwt_token
from rest_framework import routers

from .views import *


router = routers.DefaultRouter()
# router.register('plans', PlanViewSet, base_name='plans-list')
router.register('profiles', ProfileViewSet, base_name='profiles-list')
router.register('users', UserViewSet, base_name='profiles-list')
router.register('club', ClubViewSet, base_name='club-list')
router.register('match', MatchViewSet, base_name='match-list')
router.register('action', ActionViewSet, base_name='action-list')
router.register('metric', MetricViewSet, base_name='metric-list')
router.register('matchaction', MatchActionViewSet, base_name='match-action-list')
router.register('seasons', SeasonViewSet, base_name='season-list')
router.register('leagues', LeagueViewSet, base_name='league-list')
router.register('config', ConfigViewSet, base_name='config-list')


urlpatterns = [
    path('api-token-auth/', obtain_jwt_token),
    path('api-token-refresh/', refresh_jwt_token),
    path('api-token-verify/', verify_jwt_token),

    path('match-csv', MatchCSVView.as_view()),
    path('match-json', MatchJSONView.as_view()),
    path('metric-csv', MetricCSVView.as_view()),
    path('bulk-match', BulkMatchView.as_view())
] + router.urls

# urlpatterns = [
#     path('api-token-auth/', obtain_jwt_token),
# ]
