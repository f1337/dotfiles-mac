import { styled } from "uebersicht"
import moment from "moment"

const colorsToGPIOPins = {
  red: '17',
  yellow: '27',
  green: '22'
};

const officeHours = {
  start: moment('8:00', 'h:mm'),
  end: moment('19:00', 'h:mm')
};

const dayStart = () => {
  // console.log('daystart');
};

const dayEnd = () => {
  setLight('red', false);
  setLight('yellow', false);
  setLight('green', false);
};

const eventStart = (event) => {
  setLight('yellow', false);
  setLight('green', false);

  if (moment().isBetween(officeHours.start, officeHours.end)) {
    setLight('red', true);
  }
};

const eventEnd = (event) => {
  setLight('red', false);
  setLight('yellow', false);

  if (moment().isBetween(officeHours.start, officeHours.end)) {
    setLight('green', true);
  }
};

const setLight = (color, on) => {
  const api = 'http://pi.light:80/gpio/';
  const pin = colorsToGPIOPins[color];
  const proxy = 'http://127.0.0.1:41417/';
  const value = { value: on ? '0' : '1' };

  fetch(proxy + api + pin, {
    method: 'PUT',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Requested-With': 'uebersicht'
    },
    body: JSON.stringify(value)
  }).then(response => {
    // console.log(response);
  }, error => {
    console.log(error);
  });
};

export const className = `
  color: #fff;
  font-family: Helvetica Neue;
  font-size: 16px;
  font-weight: 200;
  order: 1;
  text-shadow: 0 0 1px rgba(#000, 0.5);
`

const Title = styled("div")`
  font-weight: 400;
  font-size: 18px;
  padding: 6px;
`

const Wrapper = styled("div")`
  width: 100%;
  display: inline-block;
`

const EventTitle = styled("div")`
  font-weight: 300;
  padding-top: 5px;
  padding-left: 10px;
  margin-left: 1.1em;
  text-indent: -1.1em;
`

const EventTime = styled("div")`
  font-weight: 200;
  padding-left: 30px;
`

const Today = styled("div")`
  padding-bottom:10px;
`

const Square = styled("span")`
  font-size: 18px;
  color: #ccb5fc;
`

const Heart = styled("span")`
  font-size: 9px;
  color: #f4bdf7;
`

const Triangle = styled("span")`
  color: #fff49b;
  font-size: 9px;
`

const Fire = styled("span")`
  font-size: 18px;
  color: #fff49b;
`

const Circle = styled("span")`
  font-size: 18px;
  color: #a0f2a4;
`

export const command = "./cuteical.widget/icalBuddy -nrd -nc -b '❤︎ ' -eep 'location,url,notes,attendees' eventsFrom:now to:today";
export const refreshFrequency = 60000; // milliseconds

const delimiter = '❤︎ ';

const bullets = [
  <Square>■</Square>,
  <Heart>♥</Heart>,
  <Triangle>▲</Triangle>,
  <Circle>●</Circle>
];

export const init = (dispatch) => {
  setupAlarmCallbacks(officeHours, dayStart, dayEnd);
};

const momentFor = (date, time) => {
  let datetime = date.concat(' ', time);
  return moment(datetime, 'MMM D YYYY h:mm A');
};

const parseDatetime = (datetime) => {
  let date, end, start, time;

  [date, time] = datetime.split(' at ');
  [start, end] = time.split(' - ');

  return {
    date: date,
    end: momentFor(date, end),
    start: momentFor(date, start),
    time: time,
  }
};

const parseEvent = (line) => {
  let _crlf, datetime, title;

  [title, datetime, _crlf] = line.split(/\n\s*/);
  datetime = parseDatetime(datetime);
  setupAlarmCallbacks(datetime, eventStart, eventEnd);

  return Object.assign(datetime, {
    title: title
  });
};

const parseEvents = (output) => {
  const events = [];
  const lines = output.split(delimiter);

  lines.forEach((line, idx) => {
    if (line != '') {
      let event = parseEvent(line);
      let bullet = bullets[idx % 4];

      events.push(
        <div>
          <EventTitle>{bullet} {event.title}</EventTitle>
          <EventTime>{event.time}</EventTime>
        </div>
      );
    }
  });

  if (events.length < 1) {
    events.push(
      <EventTitle>
        <Fire>☲</Fire> Let yesterday burn and throw it in the fire.
      </EventTitle>
    );
  }

  return events;
};

export const render = (output) => {
  return (
    <Wrapper>{output}</Wrapper>
  );
};

const setupAlarmCallbacks = (datetime, startCallback, endCallback) => {
  return;
  let now = moment();
  let endTimeout = 0;
  let startTimeout = 0;

  // on event start, call event start callback
  if (datetime.start) {
    startTimeout = datetime.start.diff(now);
    if (startTimeout > 0) {
      window.setTimeout(function() { startCallback(datetime); }, startTimeout);
    }
  }

  // on event end, call event end callback
  if (datetime.end) {
    endTimeout = datetime.end.diff(now);
    if (endTimeout > 0) {
      window.setTimeout(function() { endCallback(datetime); }, endTimeout);
    }
  }

  // handle events currently in progress
  if (startTimeout <= 0 && endTimeout > 0) {
    startCallback(datetime);
  }
};

export const updateState = (event, previousState) => {
  let events_html = parseEvents(event.output);
  return (
    <Today>
      <Title>Today</Title>
      {events_html}
    </Today>
  );
};
