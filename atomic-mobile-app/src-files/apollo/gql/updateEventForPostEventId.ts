import { gql } from "@apollo/client";


export default gql`
mutation UpdateEventForPostEventId($id: String!, $postEventId: String!, $timeBlocking:jsonb) {
  update_Event_by_pk(pk_columns: {id: $id}, _set: {postEventId: $postEventId, timeBlocking: $timeBlocking}) {
    id
    startDate
    endDate
    allDay
    recurrence
    recurrenceRule
    location
    notes
    attachments
    links
    timezone
    taskId
    taskType
    priority
    followUpEventId
    isFollowUp
    isPreEvent
    isPostEvent
    preEventId
    postEventId
    modifiable
    forEventId
    conferenceId
    maxAttendees
    attendeesOmitted
    sendUpdates
    anyoneCanAddSelf
    guestsCanInviteOthers
    guestsCanSeeOtherGuests
    originalStartDate
    originalTimezone
    originalAllDay
    status
    summary
    transparency
    visibility
    recurringEventId
    iCalUID
    htmlLink
    colorId
    creator
    organizer
    endTimeUnspecified
    extendedProperties
    hangoutLink
    guestsCanModify
    locked
    source
    eventType
    privateCopy
    backgroundColor
    foregroundColor
    useDefaultAlarms
    deleted
    createdDate
    updatedAt
    userId
    calendarId
    positiveImpactScore
    negativeImpactScore
    positiveImpactDayOfWeek
    positiveImpactTime
    negativeImpactDayOfWeek
    negativeImpactTime
    preferredDayOfWeek
    preferredTime
    isExternalMeeting
    isExternalMeetingModifiable
    isMeetingModifiable
    isMeeting
    dailyTaskList
    weeklyTaskList
    isBreak
    preferredStartTimeRange
    preferredEndTimeRange
    copyAvailability
    copyTimeBlocking
    copyTimePreference
    copyReminders
    copyPriorityLevel
    copyModifiable
    copyCategories
    copyIsBreak
    userModifiedAvailability
    userModifiedTimeBlocking
    userModifiedTimePreference
    userModifiedReminders
    userModifiedPriorityLevel
    userModifiedCategories
    userModifiedModifiable
    userModifiedIsBreak
    hardDeadline
    softDeadline
    copyIsMeeting
    copyIsExternalMeeting
    userModifiedIsMeeting
    userModifiedIsExternalMeeting
    duration
    copyDuration
    userModifiedDuration
    method
    unlink
    copyColor
    userModifiedColor
    byWeekDay
    localSynced
    title
    timeBlocking
    meetingId
    eventId
  }
}
`