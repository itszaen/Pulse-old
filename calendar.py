#!/usr/bin/env python3

from __future__ import print_function
import httplib2
import os

from apiclient import discovery
from oauth2client import client
from oauth2client import tools
from oauth2client.file import Storage
 
import datetime
import dateutil.tz
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('calendar', default='primary', nargs='?')
args = parser.parse_args()

# If modifying these scopes, delete your previously saved credentials
# at ~/.config/conky/.credential/
SCOPES = 'https://www.googleapis.com/auth/calendar.readonly'
CLIENT_SECRET_FILE = 'client_secret.json'
APPLICATION_NAME = 'conky-calendar'
 
 
def get_credentials():
    """Gets valid user credentials from storage.
 
    If nothing has been stored, or if the stored credentials are invalid,
    the OAuth2 flow is completed to obtain the new credentials.
 
    Returns:
        Credentials, the obtained credential.
    """
    curdir = os.path.expanduser('~/.config/conky/')
    credential_dir = os.path.join(curdir, '.credentials')
    if not os.path.exists(credential_dir):
        os.makedirs(credential_dir)
    credential_path = os.path.join(credential_dir,
                                   'calendar.json')
 
    store = Storage(credential_path)
    credentials = store.get()
    if not credentials or credentials.invalid:
        flow = client.flow_from_clientsecrets(CLIENT_SECRET_FILE, SCOPES)
        flow.user_agent = APPLICATION_NAME
        credentials = tools.run(flow, store)
        print('Storing credentials to ' + credential_path)
    return credentials


def get_calendar():
    curdir = os.path.expanduser('~/.config/conky/')
    path = curdir + "/.tmp/events"
    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    service = discovery.build('calendar', 'v3', http=http)
 
    now = datetime.datetime.now(dateutil.tz.tzlocal())
    min_date = datetime.datetime(now.year, now.month, 1).isoformat('T') + "Z"
    max_date = datetime.datetime(now.year, now.month+1, 1).isoformat('T') + "Z"

    events_result = service.events().list(
        calendarId=args.calendar, timeMin=min_date, timeMax=max_date, singleEvents=True,
        orderBy='startTime').execute()
    events = events_result.get('items', [])

    file = open(path, 'w+')

    if not events:
        print('No upcoming events found.')
    for event in events:
        day, time_start, time_end = "", "", ""
        for i in [8, 9]:
            day += event['start']['dateTime'][i]
        for i in list(range(11, 16)):
            time_start += event['start']['dateTime'][i]
            time_end += event['end']['dateTime'][i]
        line = day + ' ' + time_start + ' ' + time_end + ' ' + event['summary']+"\n"
        file.write(line)


if __name__ == '__main__':
    get_calendar()


