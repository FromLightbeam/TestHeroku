# Generated by Django 2.1.7 on 2019-05-16 22:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0007_auto_20190516_2218'),
    ]

    operations = [
        migrations.AlterField(
            model_name='configparser',
            name='club1Field',
            field=models.CharField(blank=True, max_length=50),
        ),
        migrations.AlterField(
            model_name='configparser',
            name='club2Field',
            field=models.CharField(blank=True, max_length=50),
        ),
        migrations.AlterField(
            model_name='configparser',
            name='dateField',
            field=models.CharField(blank=True, max_length=50),
        ),
        migrations.AlterField(
            model_name='configparser',
            name='dateFormat',
            field=models.CharField(blank=True, max_length=50),
        ),
        migrations.AlterField(
            model_name='configparser',
            name='leagueField',
            field=models.CharField(blank=True, max_length=50),
        ),
        migrations.AlterField(
            model_name='configparser',
            name='seasonField',
            field=models.CharField(blank=True, max_length=50),
        ),
        migrations.AlterField(
            model_name='configparser',
            name='seasonFormat',
            field=models.CharField(blank=True, max_length=20),
        ),
    ]