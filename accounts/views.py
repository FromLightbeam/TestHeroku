from django.shortcuts import render
from django.contrib.auth.models import User

from rest_framework.views import APIView
from rest_framework.permissions import AllowAny
from rest_framework import mixins, viewsets
from rest_framework.response import Response

from .models import *
from .serializers import *

import re
import csv
import json
import datetime
import pandas as pd

from .helper import get_or_create
from io import StringIO
# Create your views here.


class MatchActionViewSet(viewsets.ModelViewSet):
    serializer_class = MatchActionSerializer
    queryset = MatchAction.objects.all()


class ActionViewSet(viewsets.ModelViewSet):
    serializer_class = ActionSerializer
    queryset = Action.objects.all()


class ClubViewSet(viewsets.ModelViewSet):
    serializer_class = ClubSerializer
    queryset = Club.objects.all()


class ProfileViewSet(viewsets.ModelViewSet):
    serializer_class = ProfileSerializer
    queryset = Profile.objects.all()


class SeasonViewSet(viewsets.ModelViewSet):
    serializer_class = SeasonSerializer
    queryset = Season.objects.all()


class LeagueViewSet(viewsets.ModelViewSet):
    serializer_class = LeagueSerializer
    queryset = League.objects.all()


class ConfigViewSet(viewsets.ModelViewSet):
    serializer_class = ConfigSerializer
    queryset = ConfigParser.objects.all()

# class PlanViewSet(viewsets.ModelViewSet):

#     serializer_class = PlanSerializer
#     queryset = Plan.objects.all()


class UserViewSet(viewsets.ModelViewSet):
    serializer_class = UserSerializer
    queryset = User.objects.all()
    permission_classes = [AllowAny]


class MatchViewSet(viewsets.ModelViewSet):
    serializer_class = MatchSerializer

    def get_queryset(self):
        queryset = Match.objects.all()
        season = self.request.query_params.get('season')
        league = self.request.query_params.get('league')
        # print(season)
        if season:
            queryset = queryset.filter(season__name=season, )
        if league:
            queryset = queryset.filter(league__name=league)

        return queryset


class MetricViewSet(viewsets.ModelViewSet):
    serializer_class = MatchMetricSerializer

    def get_queryset(self):
        queryset = MatchMetric.objects.all()
        match = self.request.query_params.get('match')

        if match:
            queryset = queryset.filter(match__id=match)

        return queryset

requried_fields = {
    'date': 'Date',
    'club_1': 'HomeTeam',
    'club_2': 'AwayTeam'
}

# TODO bad naming
# May be this api need a separate file?
class MatchCSVView(APIView):
    def post(self, request, format=None):
        # TODO sep request for configure that

        # TODO sep func need
        file_name = request.data['file'].name
        season_name = re.findall("[\d/]+-?[\d]*", file_name)
        season_name = season_name[0] if len(season_name) else 'default'

        # TODO Read about chunks. read() may be bad desicion for big data
        csv_file = request.data['file'].read().decode('utf-8')

        data = pd.read_csv(StringIO(csv_file))
        # SHEEEEEEEEEEEEEEEEET WARNING FIX IT FIX IT FIX IT FIX IT FIX IT 
        league = get_or_create(League, { 'name': 'LaLiga' })
        # FIX IT FIX IT FIX IT FIX IT FIX IT FIX IT FIX IT FIX IT FIX IT 
        season = get_or_create(Season, { 'name': season_name })
    
        # print(reader)
        metrics = []
        # TODO sep func need
        for field in data.columns.values:
            if not field in requried_fields.values():
                metrics.append(get_or_create(Metric, { 'shortname': field }))

        for index, row in data.iterrows():
            club_1 = get_or_create(Club, {'name': row[requried_fields['club_1']] })
            club_2 = get_or_create(Club, {'name': row[requried_fields['club_2']] })
            match = get_or_create(
                Match, 
                {
                    'club_1': club_1,
                    'club_2': club_2,
                    'league': league,
                    'season': season,
                    'date': row[requried_fields['date']]
                }
            )
            for metric in metrics:
                # get or create tooooo long
                MatchMetric.objects.create(
                    value=row[metric.shortname],
                    match=match,
                    metric=metric
                )

        return Response('tupo kracivo')


# May be it would be part parser configa?
class MetricCSVView(APIView):
    def post(self, request, format=None):
        # TODO Dry
        data = json.load(request.data['file'])

        fields = data['resources'][0]['schema']['fields']
        metrics = []
        for field in fields:
            if not field['name'] in requried_fields.values():
                metrics.append(field)
        for metric in metrics:
            Metric.objects.filter(shortname=metric['name']).update(description=metric['description'])

        return Response('darova')

# May be it would be part of config parser?
class MatchJSONView(APIView):
    def post(self, request, format=None):
        # TODO Dry
        file_name = request.data['file'].name
        # season_name = re.findall("[\d/]+-?[\d]*", file_name)
        data = json.load(request.data['file'])

        # I want sleep
        league = get_or_create(League, { 'name': 'LaLiga' })
        season = get_or_create(Season, { 'name': '1819' })

        matches = []
        for match in data:
            club_1 = get_or_create(Club, {'name': match['h']['title'] })
            club_2 = get_or_create(Club, {'name': match['a']['title'] })
            raw_date = match['datetime'].split(' ')[0].split('-')
            # datetime.date(year, month, day) 
            date = datetime.date(int(raw_date[0]), int(raw_date[1]), int(raw_date[2]))

            args = {
                'club_1': club_1,
                'club_2': club_2,
                'league': league,
                'season': season,
                'date': date
            }
            # if match['isResult']
            metrics = {
                'ForW': match['forecast']['w'],
                'ForL': match['forecast']['l'],
                'ForD': match['forecast']['d'],
                'xG_a': match['xG']['a'],
                'xG_h': match['xG']['h']
            }

            m = Match.objects.filter(**args)
            if m:
                for metric, value in metrics.items():
                    # get or create tooooo long
                    MatchMetric.objects.create(
                        value=value,
                        match=m[0],
                        metric=Metric.objects.filter(shortname=metric)[0]
                    )

        print(len(matches))
        

        return Response('dobryi vecher')

class BulkMatchView(APIView):
    def post(self, request, format=None, *args, **kwargs):
        name = kwargs['config']
        config = get_or_create(ConfigParser, {'name': name})
        requried_fields = {
            'date': config.dateField,
            'club_1': config.club1Field,
            'club_2': config.club2Field
        }
        isLeagueField = bool(config.leagueField)
        isSeasonField = bool(config.seasonField)
        if isLeagueField:
            requried_fields['league'] = config.leagueField
        if isSeasonField:
            requried_fields['season'] = config.seasonField
        exclude = config.metricsExclude.split(',')
        
        print(requried_fields)
        print(exclude)

        # TODO Dry
        csv_file = request.data['file'].read().decode('utf-8')
        data = pd.read_csv(StringIO(csv_file))

        metrics = []
        # TODO sep func need
        for field in data.columns.values:
            if not field in requried_fields.values():
                if not field in exclude:
                    metrics.append(get_or_create(Metric, { 'shortname': field }))
        matches = []
        match_metrics = []

        for index, row in data.iterrows():
            raw_season = str(row[requried_fields['season']] if isSeasonField else config.seasonName)
            print(type(raw_season))
            print(raw_season)
            if raw_season[0:2] == '20':
                temp = int(raw_season[2:4])
                raw_season = '{0}/{1}'.format(temp, temp + 1)
            league = get_or_create(League, { 'name': row[requried_fields['league']] if isLeagueField else config.leagueName })
            season = get_or_create(Season, { 'name': raw_season })
            club_1 = get_or_create(Club, {'name': row[requried_fields['club_1']] })
            club_2 = get_or_create(Club, {'name': row[requried_fields['club_2']] })

            # league = League.objects.get(name=row[requried_fields['league']])
            # season = Season.objects.get(name=row[requried_fields['season']])
            # club_1 = Club.objects.get(name=row[requried_fields['club_1']])
            # club_2 = Club.objects.get(name=row[requried_fields['club_2']])
            if config.dateFormat == 'datetime':
                date = row[requried_fields['date']].split()[0]
            elif config.dateFormat == 'date':
                date = row[requried_fields['date']]

            print(club_1.name)
            print(club_2.name)
            print(date)
            print(club_1.name + club_2.name + date)
            print(hash(club_1.name + club_2.name + date) % 2147483647)
            args = {
                'id': hash(club_1.name + club_2.name + date) % 2147483647,
                'club_1': club_1,
                'club_2': club_2,
                'league': league,
                'season': season,
                'date': date
            }
            # print(args)
            match = Match(**args)
            try:
                Match.objects.get(id=match.id)
            except Match.DoesNotExist:
                matches.append(match)

            for metric in metrics:
                match_metrics.append(
                    MatchMetric(
                        value=row[metric.shortname],
                        match=match,
                        metric=metric
                    )
                )
                       
        Match.objects.bulk_create(matches)
        MatchMetric.objects.bulk_create(match_metrics)


        return Response('dobryi vecher')
