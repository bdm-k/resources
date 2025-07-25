import os from 'os'
import fs from 'fs'

type Record = {
  action: 'sleep' | 'wake';
  timestamp: Date;
};

let XDG_STATE_HOME: string = process.env.XDG_STATE_HOME || '';
if (!XDG_STATE_HOME) {
  XDG_STATE_HOME = os.homedir() + '/.local/state'
}

const filePath = XDG_STATE_HOME + '/sleep-record.log'
const fileContent = fs.readFileSync(filePath, 'utf8');
const records = parse(fileContent);

describe(records);
newline();
visualize(records);

function describe(records: Record[]) {
  for (const lookbackHours of [24, 48, 72]) {
    const sleepTime = getSleepTime(records, hoursToMilliseconds(lookbackHours));
    console.log(`last ${lookbackHours}h: ${sprintUnixTime(sleepTime)}`);
  }
}

function visualize(records: Record[]) {
  console.log('72h ago'.padEnd(48, ' ') + '48h ago'.padEnd(48, ' ') + '24h ago'.padEnd(48, ' '));
  console.log(('┳' + '━'.repeat(47)).repeat(3));

  let nowTime = Date.now();
  let windowEndTime = nowTime - hoursToMilliseconds(71.5);
  for (; windowEndTime <= nowTime; windowEndTime += hoursToMilliseconds(0.5)) {
    const sleepTime = getSleepTime(records, hoursToMilliseconds(0.5), windowEndTime);
    if (sleepTime >= hoursToMilliseconds(0.25)) {
      process.stdout.write('█');
    } else {
      process.stdout.write(' ');
    }
  }

  newline();
  console.log(('┻' + '━'.repeat(47)).repeat(3));
}

function getSleepTime(
  records: Record[],
  lookbackTime: number,
  nowTime: number = Date.now()
): number {
  const startTime = nowTime - lookbackTime;

  let sleepTime = 0;
  let prevRecord = records[0];
  if (!prevRecord) return 0;

  for (let i = 1; i < records.length; ++i) {
    const record = records[i];

    if (
      record.timestamp.getTime() > startTime  &&
      prevRecord.timestamp.getTime() < nowTime &&
      record.action ==  'wake'                 &&
      prevRecord.action == 'sleep'
    ) {
      const recordTime = record.timestamp.getTime();
      const prevRecordTime = prevRecord.timestamp.getTime();
      sleepTime += min(nowTime, recordTime) - max(startTime, prevRecordTime);
    }

    prevRecord = record;
  }

  return sleepTime;
}

function parse(content: string): Record[] {
  const records: Record[] = [];
  const lines = content.split('\n').filter(line => Boolean(line));

  for (const line of lines) {
    const [actionText, timestampText] = line.split(',').map(line => line.trim());

    if (!(actionText == 'sleep' || actionText == 'wake')) {
      throw new Error(`invalid action: ${actionText}`);
    }

    records.push({ action: actionText, timestamp: parseTimestampText(timestampText) });
  }

  return records;
}

function parseTimestampText(timestampText: string): Date {
  const [, monthText, dateText, timeText, , yearText] = timestampText.split(' ');
  const [hourText, minuteText, secondText] = timeText.split(':');

  const year = Number(yearText);
  const month =
    monthText == 'Jan' ?  0 :
    monthText == 'Feb' ?  1 :
    monthText == 'Mar' ?  2 :
    monthText == 'Apr' ?  3 :
    monthText == 'May' ?  4 :
    monthText == 'Jun' ?  5 :
    monthText == 'Jul' ?  6 :
    monthText == 'Aug' ?  7 :
    monthText == 'Sep' ?  8 :
    monthText == 'Oct' ?  9 :
    monthText == 'Nov' ? 10 :
    monthText == 'Dec' ? 11 : -1;
  const date = Number(dateText);
  const hour = Number(hourText);
  const minute = Number(minuteText);
  const second = Number(secondText);

  return new Date(year, month, date, hour, minute, second);
}

function sprintUnixTime(unixTime: number): string {
  let minutes = Math.floor(unixTime / (60 * 1000));
  let hours = Math.floor(minutes / 60);
  minutes %= 60;
  hours %= 100;

  const minutesText = String(minutes).padStart(2, '0');
  const hoursText = String(hours).padStart(2, '0');

  return `${hoursText}:${minutesText}`;
}

function hoursToMilliseconds(hours: number): number {
  return hours * 60 * 60 * 1000;
}

function min(a: number, b: number): number {
  return a < b ? a : b;
}

function max(a: number, b: number): number {
  return a > b ? a : b;
}

function newline() {
  console.log();
}
