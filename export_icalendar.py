from icalendar import Calendar, Event
from datetime import timedelta, datetime
import pytz, sys
import pandas as pd

# arguments
input_file = sys.argv[1]
output_file = sys.argv[2]
time = sys.argv[3]

# read fixtures calculated by R
df = pd.read_csv(input_file)

# create calendar component
cal = Calendar()
cal.add('proid', 'Stouffer/Tylianakis meetings')
cal.add('version', '2.0')

# function to add simple event subcomponents
def add_event(the_calendar, event_name, start, end):
    event = Event()
    event.add('summary', event_name)
    event.add('dtstart', start)
    event.add('dtend', end)
    the_calendar.add_component(event)
    return

# cycle through each meeting and add event to the calendar
for index ,row in df.iterrows():
    start = row['date'] + " " + time
    start = datetime.strptime(start, '%Y-%m-%d %X')
    start = start.replace(tzinfo = pytz.timezone("Pacific/Auckland"))
    end = start + timedelta(hours = 1)
    add_event(cal, row['person'], start, end)

f = open(output_file, 'wb')
f.write(cal.to_ical())
f.close()
