from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from datetime import datetime


class UserGroup(models.Model):
    name = models.CharField(max_length=32, null=False)


class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    first_name = models.CharField(max_length=50, null=False)
    second_name = models.CharField(max_length=50, null=False)
    group_id = models.ForeignKey(UserGroup, on_delete=models.CASCADE, blank=True, null=True)


class League(models.Model):
    name = models.CharField(max_length=150, null=False)

    def __str__(self):
        return self.name


class Season(models.Model):
    name = models.CharField(max_length=150)

    def __str__(self):
        return self.name


class Club(models.Model):
    name = models.CharField(max_length=150, null=False)
    logo = models.CharField(max_length=250, blank=True, null=True)

    def __str__(self):
        return self.name


class Match(models.Model):
    # Bad naming_1
    club_1 = models.ForeignKey(Club, on_delete=models.CASCADE, related_name='first_club', blank=True, null=True)
    club_2 = models.ForeignKey(Club, on_delete=models.CASCADE, related_name='second_club', blank=True, null=True)
    league = models.ForeignKey(League, on_delete=models.SET_NULL, related_name='matches', blank=True, null=True)    
    season = models.ForeignKey(Season, on_delete=models.SET_NULL, related_name='matches', blank=True, null=True)
    goal_1 = models.IntegerField(blank=True, null=True)
    goal_2 = models.IntegerField(blank=True, null=True)
    date = models.DateField()
    time = models.TimeField(blank=True, null=True)
    description = models.CharField(max_length=500, null=False)

    def __str__(self):
        return '{0}-{1}'.format(self.club_1, self.club_2)

    def get_stats(self):
        return self.stats


class Player(models.Model):
    name = models.CharField(max_length=100, unique=True)
    club = models.ForeignKey(Club, on_delete=models.CASCADE, related_name='players')


class Action(models.Model):
    name = models.CharField(max_length=50, null=False)
    def __str__(self):
        return self.name


class MatchAction(models.Model):
    match = models.ForeignKey(Match, on_delete=models.CASCADE, blank=True, null=True)
    action = models.ForeignKey(Action, on_delete=models.CASCADE, blank=True, null=True)
    result = models.NullBooleanField(blank=True, null=True)
    coefficient = models.FloatField()
    
    def __str__(self):
        return '{0}. {1}'.format(self.match, self.action)


# class Bet(models.Model):
#     action = models.ForeignKey(MatchAction, on_delete=models.CASCADE, blank=True, null=True)
#     money = models.DecimalField(max_digits=10, decimal_places=2, default=0)
#     user = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True, related_name='bets')

#     def __str__(self):
#         return '{0}. {1}'.format(self.action, self.user)


class Metric(models.Model):
    shortname = models.CharField(max_length=20, unique=True)
    description = models.CharField(max_length=500, blank=True)

    def __str__(self):
        return self.shortname


class ObjectMetric(models.Model):
    value = models.CharField(max_length=20)
    metric = models.ForeignKey(Metric, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.metric)
    
    class Meta:
        abstract = True


class MatchMetric(ObjectMetric):
    # value = models.CharField(max_length=20)
    match = models.ForeignKey(Match, on_delete=models.CASCADE, related_name='stats')
    # metric = models.ForeignKey(Metric, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.metric)


class SeasonMetric(ObjectMetric):
    # value = models.CharField(max_length=20)
    season = models.ForeignKey(Season, on_delete=models.CASCADE, related_name='stats')
    # metric = models.ForeignKey(Metric, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.metric)


class PlayerMetric(ObjectMetric):
    # value = models.CharField(max_length=20)
    player = models.ForeignKey(Player, on_delete=models.CASCADE, related_name='stats')
    # metric = models.ForeignKey(Metric, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.metric)


class ConfigParser(models.Model):
    name = models.CharField(max_length=50, unique=True)
    seasonField = models.CharField(max_length=50, blank=True)
    seasonName = models.CharField(max_length=50, blank=True)
    seasonFormat = models.CharField(max_length=20, blank=True)
    leagueField = models.CharField(max_length=50, blank=True)
    leagueName = models.CharField(max_length=20, blank=True)
    dateField = models.CharField(max_length=50, blank=True)
    dateFormat = models.CharField(max_length=50, blank=True)
    club1Field = models.CharField(max_length=50, blank=True)
    club2Field = models.CharField(max_length=50, blank=True)
    metricsExclude = models.TextField(blank=True)

    def __str__(self):
        return str(self.name)


@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()
