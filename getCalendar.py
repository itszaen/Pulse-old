from __future__ import print_function
import httplib2
import os
 
from apiclient import discovery
from oauth2client import client
from oauth2client import tools
from oauth2client.file import Storage
 
import datetime
 
try:
    import argparse
    flags = argparse.ArgumentParser(parents=[tools.argparser]).parse_args()
except ImportError:
    flags = None
 
# If modifying these scopes, delete your previously saved credentials
# at ~/.config/conky/.credential/
SCOPES = 'https://www.googleapis.com/auth/calendar.readonly'
CLIENT_SECRET_FILE = 'client_secret.json'
APPLICATION_NAME = 'conky-calendar' # I'm not sure what this is
 
 
def get_credentials():
    """Gets valid user credentials from storage.
 
    If nothing has been stored, or if the stored credentials are invalid,
    the OAuth2 flow is completed to obtain the new credentials.
 
    Returns:
        Credentials, the obtained credential.
    """
    home_dir = os.path.expanduser('~/.config/conky/')
    credential_dir = os.path.join(home_dir, '.credentials')
    if not os.path.exists(credential_dir):
        os.makedirs(credential_dir)
    credential_path = os.path.join(credential_dir,
                                   'calendar.json')
 
    store = Storage(credential_path)
    credentials = store.get()
    if not credentials or credentials.invalid:
        flow = client.flow_from_clientsecrets(CLIENT_SECRET_FILE, SCOPES)
        flow.user_agent = APPLICATION_NAME
        if flags:
            credentials = tools.run_flow(flow, store, flags)
        else: # Needed only for compatibility with Python 2.6
            credentials = tools.run(flow, store)
        print('Storing credentials to ' + credential_path)
    return credentials
 
def main():
    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    service = discovery.build('calendar', 'v3', http=http)
 
    numEvents = 10 # the number of events to get
    now = datetime.datetime.utcnow().isoformat() + 'Z' # 'Z' indicates UTC time
    print('Getting the upcoming 10 events')
    eventsResult = service.events().list(
        calendarId='primary', timeMin=now, maxResults=numEvents, singleEvents=True,
        orderBy='startTime').execute()
    events = eventsResult.get('items', [])
    # Uncomment to see the raw data
    # print(events)
 
    if not events:
        print('No upcoming events found.')
    for event in events:
        print(event['start']['dateTime'], event['summary'])
 
 
 
if __name__ == '__main__':
    main()
