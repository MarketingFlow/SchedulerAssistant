import { sendUpdates, transparency, visibility } from '@app/calendar/types'
import { RecurrenceFrequency } from 'react-native-calendar-events'

export type link = {
  title: string,
  link: string
}



export type attachment = {
  title: string,
  fileUrl: string,
  mimeType: string,
  iconLink: string,
  fileId: string
}

export type recurrenceRule = {
  frequency: RecurrenceFrequency,
  endDate: string,
  occurrence?: number,
  interval: number,
  byWeekDay?: string[],
} | {
  frequency: string,
  endDate?: string,
  occurrence: number,
  interval: number,
  byWeekDay?: string[],
}

export type LocationType = {
  title: string,
  proximity?: string,
  radius?: number,
  coords?: {
    latitude?: number,
    longitude?: number,
  },
  address?: {
    houseNumber?: number,
    prefixDirection?: string,
    prefixType?: string,
    streetName?: string,
    streetType?: string,
    suffixDirection?: string,
    city?: string,
    state?: string,
    postalCode?: string,
    country?: string
  }
}

export type creator = {
  id?: string,
  email?: string,
  displayName?: string,
  self?: boolean
}

export type organizer = {
  id: string,
  email: string,
  displayName: string,
  self: boolean
}

export type extendedProperties = {
  private?: {
    keys?: string[],
    values?: string[],
  },
  shared?: {
    keys?: string[],
    values?: string[]
  },
}

export type source = {
  url: string,
  title: string
}



type HH = '00'|'01'|'02'|'03'|'04'|'05'|'06'|'07'|'08'|'09'|'10'|'11'|'12'|'13'|'14'|'15'|'16'|'17'|'18'|'19'|'20'|'21'|'22'|'23'
type MM = '00'|'01'|'02'|'03'|'04'|'05'|'06'|'07'|'08'|'09'|'10'|'11'|'12'|'13'|'14'|'15'|'16'|'17'|'18'|'19'|'20'|'21'|'22'|'23'|'24'|'25'|'26'|'27'|'28'|'29'|'30'|'31'|'32'|'33'|'34'|'35'|'36'|'37'|'38'|'39'|'40'|'41'|'42'|'43'|'44'|'45'|'46'|'47'|'48'|'49'|'50'|'51'|'52'|'53'|'54'|'55'|'56'|'57'|'58'|'59'

export type Time = `${HH}:${MM}`

export type BufferTime = {
  beforeEvent?: number
  afterEvent?: number
}

export type EventType = {
  __typename?: 'Event',
  id: string,
  userId: string,
  title?: string,
  startDate: string,
  endDate: string,
  allDay?: boolean,
  recurrenceRule?: recurrenceRule,
  location?: LocationType,
  notes?: string,
  attachments?: attachment[],
  links?: link[],
  timezone?: string,
  createdDate: string,
  deleted: boolean,
  taskId?: string,
  taskType?: string,
  priority: number,
  followUpEventId?: string,
  isFollowUp: boolean,
  isPreEvent: boolean,
  isPostEvent: boolean,
  preEventId?: string,
  postEventId?: string,
  modifiable: boolean,
  forEventId?: string,
  conferenceId?: string,
  maxAttendees?: number,
  sendUpdates?: sendUpdates,
  anyoneCanAddSelf: boolean,
  guestsCanInviteOthers: boolean,
  guestsCanSeeOtherGuests: boolean,
  originalStartDate: string,
  originalAllDay: boolean,
  status?: string,
  summary?: string,
  transparency?: transparency,
  visibility?: visibility,
  recurringEventId?: string,
  updatedAt: string,
  iCalUID?: string,
  htmlLink?: string,
  colorId?: string,
  creator?: creator,
  organizer?: organizer,
  endTimeUnspecified?: boolean,
  recurrence?: string[],
  originalTimezone?: string,
  attendeesOmitted?: boolean,
  extendedProperties?: extendedProperties,
  hangoutLink?: string,
  guestsCanModify?: boolean,
  locked?: boolean,
  source?: source,
  eventType?: string,
  privateCopy?: boolean,
  calendarId: string,
  backgroundColor?: string,
  foregroundColor?: string,
  useDefaultAlarms?: boolean,
  positiveImpactScore?: number,
  negativeImpactScore?: number,
  positiveImpactDayOfWeek?: number,
  positiveImpactTime?: Time,
  negativeImpactDayOfWeek?: number,
  negativeImpactTime?: Time,
  preferredDayOfWeek?: number,
  preferredTime?: Time,
  isExternalMeeting?: boolean,
  isExternalMeetingModifiable?: boolean,
  isMeetingModifiable?: boolean,
  isMeeting?: boolean,
  dailyTaskList?: boolean,
  weeklyTaskList?: boolean,
  isBreak?: boolean,
  preferredStartTimeRange?: Time,
  preferredEndTimeRange?: Time,
  copyAvailability?: boolean,
  copyTimeBlocking?: boolean,
  copyTimePreference?: boolean,
  copyReminders?: boolean,
  copyPriorityLevel?: boolean,
  copyModifiable?: boolean,
  copyCategories?: boolean,
  copyIsBreak?: boolean,
  timeBlocking?: BufferTime,
  userModifiedAvailability?: boolean,
  userModifiedTimeBlocking?: boolean,
  userModifiedTimePreference?: boolean,
  userModifiedReminders?: boolean,
  userModifiedPriorityLevel?: boolean,
  userModifiedCategories?: boolean,
  userModifiedModifiable?: boolean,
  userModifiedIsBreak?: boolean,
  hardDeadline?: string,
  softDeadline?: string,
  copyIsMeeting?: boolean,
  copyIsExternalMeeting?: boolean,
  userModifiedIsMeeting?: boolean,
  userModifiedIsExternalMeeting?: boolean,
  duration?: number,
  copyDuration?: boolean,
  userModifiedDuration?: boolean,
  method?: 'create' | 'update',
  unlink?: boolean,
  copyColor?: boolean,
  userModifiedColor?: boolean,
  byWeekDay?: string[],
  localSynced?: boolean,
  eventId: string,
  meetingId?: string,
}
