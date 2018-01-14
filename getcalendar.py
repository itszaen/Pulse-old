#!/usr/bin/env python3

from __future__ import print_function
import httplib2
import os

from apiclient import discovery
from oauth2client.tools import run_flow
from oauth2client.file import Storage
from oauth2client.client import OAuth2WebServerFlow

import datetime
import dateutil.tz
import array


# If modifying these scopes, delete your previously saved credentials
# at ~/.config/conky/.credential/
SCOPES = 'https://www.googleapis.com/auth/calendar.readonly'
CLIENT_SECRET_FILE = 'client_secret.json'
APPLICATION_NAME = 'conky-calendar'
API_CLIENT_ID = '795193198115-t3r3kq653sptle0ghl43gkc68v36l9um.apps.googleusercontent.com'
API_CLIENT_SECRET = 'WxrIaJIwabzabxosSnPhQj6u'

def get_credentials():
    curdir = os.path.expanduser('~/.config/conky/')
    credential_dir = os.path.join(curdir, '.credentials')
    if not os.path.exists(credential_dir):
        os.makedirs(credential_dir)
    credential_path = os.path.join(credential_dir,
                                   'calendar.json')
    store = Storage(credential_path)
    credentials = store.get()
    if not credentials or credentials.invalid:
        credentials = run_flow(OAuth2WebServerFlow(API_CLIENT_ID, API_CLIENT_SECRET, SCOPES, APPLICATION_NAME), store)
        print('Storing credentials to ' + credential_path)
    return credentials


def get_calendar():
    curdir = os.path.expanduser('~/.config/conky/')
    path = curdir + "/.tmp/events"
    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    service = discovery.build('calendar', 'v3', http=http)

    calendar_list = service.calendarList().list().execute()
    calendar_id_list = [item['id'] for item in calendar_list['items']]

    now = datetime.datetime.now(dateutil.tz.tzlocal())
    min_date = datetime.datetime(now.year, now.month, 1).isoformat('T') + "Z"
    max_date = datetime.datetime(now.year, now.month+1, 1).isoformat('T') + "Z"

    events_list = [[] for i in range(0, 31)]

    for calendar_id in calendar_id_list:
        events_result = service.events().list(
            calendarId=calendar_id, timeMin=min_date, timeMax=max_date, singleEvents=True,
            orderBy='startTime').execute()
        events = events_result.get('items', [])

        if events:
            for event in events:
                if 'dateTime' in event['start']:
                    day, time_start, time_end = "", "", ""
                    for i in [8, 9]:
                        print(event['start'])
                        day += event['start']['dateTime'][i]
                        for i in list(range(11, 16)):
                            time_start += event['start']['dateTime'][i]
                            time_end += event['end']['dateTime'][i]
                    events_list[int(day)-1].append(day + ' ' + time_start + ' ' + time_end + ' ' + event['summary']+"\n")
                else:
                    day = ""
                    for i in [8,9]:
                        day += event['start']['date'][i]
                    events_list[int(day)-1].append(day+' '+event['summary']+"\n")
    events_list_final = ""
    for day in events_list:
        for i in day:
            events_list_final += i

    file = open(path, 'w+')
    file.write(events_list_final)


if __name__ == '__main__':
    get_calendar()
