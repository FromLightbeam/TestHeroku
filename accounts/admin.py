from django.contrib import admin
from .models import Profile, Club, Match, Action, MatchAction, Metric, MatchMetric, League, Season

admin.site.register((Profile, Club, Action, League, Season, MatchMetric))

@admin.register(Metric)
class MetricAdmin(admin.ModelAdmin):
    list_display = ('shortname', 'description')

class MetricInline(admin.TabularInline):
    model = MatchMetric

@admin.register(Match)
class MatchAdmin(admin.ModelAdmin):
    list_display = ('__str__', 'league', 'season', 'date')
    list_filter = ('league', 'season', 'date')
    inlines = [
        MetricInline,
    ]

