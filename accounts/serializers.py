from django.contrib.auth.models import User
from django.contrib.auth.hashers import make_password

from rest_framework import serializers
from .models import *


class ClubSerializer(serializers.ModelSerializer):
    class Meta:
        model = Club
        fields = '__all__'


class ActionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Action
        fields = '__all__'


class MetricSerializer(serializers.ModelSerializer):
    class Meta:
        model = Metric
        fields = '__all__'


class MatchMetricSerializer(serializers.ModelSerializer):
    metric = MetricSerializer()
    class Meta:
        model = MatchMetric
        fields = '__all__'


class MatchSerializer(serializers.ModelSerializer):
    club_1 = ClubSerializer()
    club_2 = ClubSerializer()
    # stats = MatchMetricSerializer(many=True, read_only=True)

    class Meta:
        model = Match
        # fields = ('club_1', 'club_2', 'date', 'stats')
        fields = '__all__'


class MatchActionSerializer(serializers.ModelSerializer):
    action = ActionSerializer()
    match = MatchSerializer()
    class Meta:
        model = MatchAction
        fields = '__all__'


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = '__all__'


class SeasonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Season
        fields = '__all__'


class LeagueSerializer(serializers.ModelSerializer):
    class Meta:
        model = League
        fields = '__all__'


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'
    
    def create(self, validated_data):
        user = User.objects.create(
            username=validated_data['username'],
            password = make_password(validated_data['password'])
        )
        return user


class ConfigSerializer(serializers.ModelSerializer):
    class Meta:
        model = ConfigParser
        fields = '__all__'
