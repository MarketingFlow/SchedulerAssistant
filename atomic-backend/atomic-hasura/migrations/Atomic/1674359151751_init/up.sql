SET check_function_bodies = false;
CREATE FUNCTION public."set_current_timestamp_lastRead"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."lastRead" = NOW();
  RETURN _new;
END;
$$;
CREATE FUNCTION public."set_current_timestamp_lastSeen"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."lastSeen" = NOW();
  RETURN _new;
END;
$$;
CREATE FUNCTION public."set_current_timestamp_updatedAt"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updatedAt" = NOW();
  RETURN _new;
END;
$$;
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public."Active_Subscription" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "userId" uuid NOT NULL,
    "subscriptionId" text NOT NULL,
    "transactionId" text NOT NULL,
    "startDate" timestamp with time zone DEFAULT now() NOT NULL,
    "endDate" timestamp with time zone NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    status boolean DEFAULT false NOT NULL
);
COMMENT ON TABLE public."Active_Subscription" IS 'user''s active subscriptions';
CREATE TABLE public."Admin" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    token text,
    "clientId" text,
    "clientSecret" text,
    resource text NOT NULL,
    password text,
    code text,
    secret text,
    usage integer DEFAULT 5,
    period text DEFAULT 'MONTH'::text
);
COMMENT ON TABLE public."Admin" IS 'table for client secrets, tokens etc';
CREATE TABLE public."Admin_Beta_Testing" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "enableTesting" boolean DEFAULT false NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);
COMMENT ON TABLE public."Admin_Beta_Testing" IS 'boolean to enable or disable all features for testing';
CREATE TABLE public."Attendee" (
    id text DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    "userId" uuid NOT NULL,
    "contactId" text,
    emails jsonb,
    "phoneNumbers" jsonb,
    "imAddresses" jsonb,
    "eventId" text NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "additionalGuests" integer DEFAULT 0,
    comment text,
    optional boolean DEFAULT false NOT NULL,
    "responseStatus" text,
    resource boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."Attendee" IS 'attendees to an event';
CREATE TABLE public."Autopilot" (
    id uuid NOT NULL,
    "userId" uuid NOT NULL,
    "scheduleAt" timestamp without time zone NOT NULL,
    timezone text NOT NULL,
    payload jsonb,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public."Autopilot" IS 'autopilot to create recurring scheduled triggers';
CREATE TABLE public."Calendar" (
    id text DEFAULT public.gen_random_uuid() NOT NULL,
    "userId" uuid NOT NULL,
    title text,
    "backgroundColor" text,
    account jsonb,
    "accessLevel" text,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modifiable boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "defaultReminders" jsonb,
    resource text,
    "primary" boolean DEFAULT false,
    "globalPrimary" boolean DEFAULT false,
    "colorId" text,
    "foregroundColor" text,
    "pageToken" text,
    "syncToken" text
);
CREATE TABLE public."Calendar_Integration" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "userId" uuid NOT NULL,
    token text,
    "refreshToken" text,
    resource text,
    name text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "expiresAt" timestamp with time zone,
    "syncEnabled" boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "appId" text,
    "appEmail" text,
    "appAccountId" text,
    username text,
    password text,
    "contactName" text,
    "contactEmail" text,
    colors jsonb,
    "pageToken" text,
    "syncToken" text,
    "clientType" text,
    "contactFirstName" text,
    "contactLastName" text,
    "phoneCountry" text,
    "phoneNumber" text
);
COMMENT ON TABLE public."Calendar_Integration" IS 'integrations for the calendar';
CREATE TABLE public."Calendar_Push_Notification" (
    id text NOT NULL,
    "userId" uuid NOT NULL,
    "resourceId" text NOT NULL,
    "calendarId" text NOT NULL,
    token text NOT NULL,
    "resourceUri" text NOT NULL,
    expiration timestamp with time zone,
    "calendarIntegrationId" uuid NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "createdDate" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."Calendar_Push_Notification" IS 'calendar push notification for calendars';
CREATE TABLE public."Category" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "userId" uuid NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "copyAvailability" boolean DEFAULT false,
    "copyTimeBlocking" boolean,
    "copyTimePreference" boolean DEFAULT false,
    "copyReminders" boolean DEFAULT false,
    "copyPriorityLevel" boolean DEFAULT false,
    "copyModifiable" boolean DEFAULT false,
    "defaultAvailability" boolean DEFAULT false,
    "defaultTimeBlocking" jsonb,
    "defaultTimePreference" jsonb,
    "defaultReminders" jsonb,
    "defaultPriorityLevel" integer,
    "defaultModifiable" boolean,
    "copyIsBreak" boolean,
    color text,
    "defaultIsBreak" boolean DEFAULT false,
    "copyMeetingModifiable" boolean DEFAULT false,
    "copyExternalMeetingModifiable" boolean DEFAULT false,
    "copyIsMeeting" boolean DEFAULT false,
    "copyIsExternalMeeting" boolean DEFAULT false,
    "defaultIsMeeting" boolean DEFAULT false,
    "defaultIsExternalMeeting" boolean DEFAULT false,
    "defaultMeetingModifiable" boolean DEFAULT true,
    "defaultExternalMeetingModifiable" boolean DEFAULT true
);
COMMENT ON TABLE public."Category" IS 'category for events';
CREATE TABLE public."Category_Event" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "categoryId" uuid NOT NULL,
    "eventId" text NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "userId" uuid NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."Category_Event" IS 'many to many relationship';
CREATE TABLE public."Conference" (
    id text DEFAULT public.gen_random_uuid() NOT NULL,
    "requestId" uuid DEFAULT public.gen_random_uuid() NOT NULL,
    type text,
    status text,
    "calendarId" text NOT NULL,
    "iconUri" text,
    name text,
    notes text,
    "entryPoints" jsonb,
    parameters jsonb,
    app text,
    "userId" uuid NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "createdDate" timestamp with time zone DEFAULT now(),
    deleted boolean DEFAULT false NOT NULL,
    key text,
    "hangoutLink" text,
    "joinUrl" text,
    "startUrl" text,
    "zoomPrivateMeeting" boolean DEFAULT false,
    "isHost" boolean DEFAULT false
);
COMMENT ON TABLE public."Conference" IS 'zoom or google meet conferences, will be modified to match each service';
CREATE TABLE public."Contact" (
    id text DEFAULT public.gen_random_uuid() NOT NULL,
    name text,
    "firstName" text,
    "middleName" text,
    "lastName" text,
    "maidenName" text,
    "namePrefix" text,
    "nameSuffix" text,
    nickname text,
    "phoneticFirstName" text,
    "phoneticMiddleName" text,
    "phoneticLastName" text,
    company text,
    "jobTitle" text,
    department text,
    notes text,
    "imageAvailable" boolean DEFAULT false NOT NULL,
    image text,
    "contactType" text DEFAULT 'person'::text NOT NULL,
    emails jsonb,
    "phoneNumbers" jsonb,
    "imAddresses" jsonb,
    "linkAddresses" jsonb,
    "userId" uuid NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    app text
);
CREATE TABLE public."Contact_Event" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "contactId" text NOT NULL,
    "eventId" text NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "userId" uuid NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."Contact_Event" IS 'many to many relationships for contact and events';
CREATE TABLE public."Event" (
    id text NOT NULL,
    "userId" uuid NOT NULL,
    title text,
    "startDate" timestamp without time zone DEFAULT now() NOT NULL,
    "endDate" timestamp without time zone DEFAULT now() NOT NULL,
    "allDay" boolean DEFAULT false NOT NULL,
    "recurrenceRule" jsonb,
    location jsonb,
    notes text,
    attachments jsonb,
    links jsonb,
    timezone text,
    "createdDate" timestamp with time zone DEFAULT now(),
    deleted boolean DEFAULT false NOT NULL,
    "taskId" uuid,
    "taskType" text,
    priority integer DEFAULT 1 NOT NULL,
    "followUpEventId" text,
    "isFollowUp" boolean DEFAULT false NOT NULL,
    "isPreEvent" boolean DEFAULT false NOT NULL,
    "isPostEvent" boolean DEFAULT false NOT NULL,
    "preEventId" text,
    "postEventId" text,
    modifiable boolean DEFAULT false NOT NULL,
    "forEventId" text,
    "conferenceId" text,
    "maxAttendees" integer DEFAULT 1,
    "sendUpdates" text,
    "anyoneCanAddSelf" boolean DEFAULT false NOT NULL,
    "guestsCanInviteOthers" boolean DEFAULT true NOT NULL,
    "guestsCanSeeOtherGuests" boolean DEFAULT true NOT NULL,
    "originalStartDate" timestamp with time zone DEFAULT now() NOT NULL,
    "originalAllDay" boolean DEFAULT false NOT NULL,
    status text,
    summary text,
    transparency text,
    visibility text,
    "recurringEventId" text,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "iCalUID" text,
    "htmlLink" text,
    "colorId" text,
    creator jsonb,
    organizer jsonb,
    "endTimeUnspecified" boolean DEFAULT false,
    recurrence jsonb,
    "originalTimezone" text,
    "attendeesOmitted" boolean DEFAULT false,
    "extendedProperties" jsonb,
    "hangoutLink" text,
    "guestsCanModify" boolean DEFAULT false,
    locked boolean DEFAULT false,
    source jsonb,
    "eventType" text,
    "privateCopy" boolean DEFAULT false,
    "calendarId" text NOT NULL,
    "backgroundColor" text,
    "foregroundColor" text,
    "useDefaultAlarms" boolean DEFAULT true,
    "positiveImpactScore" integer DEFAULT 0,
    "negativeImpactScore" integer DEFAULT 0,
    "positiveImpactDayOfWeek" integer,
    "positiveImpactTime" time without time zone,
    "negativeImpactDayOfWeek" integer,
    "negativeImpactTime" time without time zone,
    "preferredDayOfWeek" integer,
    "preferredTime" time without time zone,
    "isExternalMeeting" boolean,
    "isExternalMeetingModifiable" boolean,
    "isMeetingModifiable" boolean,
    "isMeeting" boolean,
    "dailyTaskList" boolean,
    "weeklyTaskList" boolean,
    "isBreak" boolean,
    "preferredStartTimeRange" time without time zone,
    "preferredEndTimeRange" time without time zone,
    "copyAvailability" boolean,
    "copyTimeBlocking" boolean,
    "copyTimePreference" boolean,
    "copyReminders" boolean,
    "copyPriorityLevel" boolean,
    "copyModifiable" boolean,
    "copyCategories" boolean,
    "copyIsBreak" boolean,
    "timeBlocking" jsonb,
    "userModifiedAvailability" boolean DEFAULT false,
    "userModifiedTimeBlocking" boolean DEFAULT false,
    "userModifiedTimePreference" boolean DEFAULT false,
    "userModifiedReminders" boolean DEFAULT false,
    "userModifiedPriorityLevel" boolean DEFAULT false,
    "userModifiedCategories" boolean DEFAULT false,
    "userModifiedModifiable" boolean DEFAULT false,
    "userModifiedIsBreak" boolean DEFAULT false,
    "softDeadline" timestamp without time zone,
    "hardDeadline" timestamp without time zone,
    "copyMeetingModifiable" boolean DEFAULT false,
    "copyExternalMeetingModifiable" boolean DEFAULT false,
    "userModifiedMeetingModifiable" boolean DEFAULT false,
    "userModifiedExternalMeetingModifiable" boolean DEFAULT false,
    "copyIsMeeting" boolean DEFAULT false,
    "copyIsExternalMeeting" boolean DEFAULT false,
    "userModifiedIsMeeting" boolean DEFAULT false,
    "userModifiedIsExternalMeeting" boolean DEFAULT false,
    duration integer,
    "copyDuration" boolean DEFAULT false,
    "userModifiedDuration" boolean DEFAULT false,
    method text,
    unlink boolean DEFAULT false,
    "copyColor" boolean DEFAULT false,
    "userModifiedColor" boolean DEFAULT false,
    "byWeekDay" jsonb,
    "localSynced" boolean DEFAULT false,
    "meetingId" text,
    "eventId" text
);
CREATE TABLE public."Event_Trigger" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    resource text NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "userId" uuid NOT NULL,
    "resourceId" text NOT NULL
);
COMMENT ON TABLE public."Event_Trigger" IS 'event triggers created to sync data';
CREATE TABLE public."Feedback" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "userId" uuid NOT NULL,
    question2 text,
    question3 text,
    question4 text,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "question1_A" boolean DEFAULT false NOT NULL,
    "question1_B" boolean DEFAULT false NOT NULL,
    "question1_C" boolean DEFAULT false NOT NULL,
    count integer DEFAULT 0,
    "lastSeen" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."Feedback" IS 'feedback about products from users';
CREATE TABLE public."Freemium" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "userId" uuid NOT NULL,
    usage integer DEFAULT 5 NOT NULL,
    period text DEFAULT 'MONTH'::text NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public."Freemium" IS 'free version service for free users';
CREATE TABLE public."Group" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    email text,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."Group" IS 'groups for group calendar and events';
CREATE TABLE public."GroupCalendar" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "groupId" uuid NOT NULL,
    title text NOT NULL,
    color text,
    account jsonb,
    "accessLevel" text,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."GroupCalendar" IS 'group calendar for sync';
CREATE TABLE public."GroupCalendar_GroupEvent" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "groupCalendarId" uuid NOT NULL,
    "groupEventId" uuid NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."GroupCalendar_GroupEvent" IS 'many to many  relationships for Group calendar and event';
CREATE TABLE public."GroupCategory" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "groupId" uuid NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."GroupCategory" IS 'group categories';
CREATE TABLE public."GroupCategory_GroupEvent" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "groupCategoryId" uuid NOT NULL,
    "groupEventId" uuid NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."GroupCategory_GroupEvent" IS 'many to many relationships for group category to group event';
CREATE TABLE public."GroupEvent" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "groupId" uuid NOT NULL,
    title text NOT NULL,
    "startDate" timestamp with time zone NOT NULL,
    "endDate" timestamp with time zone NOT NULL,
    "allDay" boolean DEFAULT false NOT NULL,
    recurrence text,
    "recurrenceRule" jsonb,
    location jsonb,
    notes text,
    attachments jsonb,
    attendees jsonb,
    links jsonb,
    alarms jsonb,
    timezone text,
    virtual jsonb,
    "taskId" text,
    "taskType" text,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    priority integer DEFAULT 1 NOT NULL,
    "followUpEventId" uuid,
    "isFollowUp" boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."GroupEvent" IS 'events in inside group calendars';
CREATE TABLE public."Group_User" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "groupId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
CREATE TABLE public."Invite" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "userId" uuid NOT NULL,
    emails jsonb,
    "phoneNumbers" jsonb,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    name text,
    "eventId" uuid,
    "imAddresses" jsonb,
    categories jsonb,
    "availableSlots" jsonb,
    "emailId" text,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "contactId" text,
    "phoneId" text
);
COMMENT ON TABLE public."Invite" IS 'invite table for custom calendars';
CREATE TABLE public."Meeting_Assist" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "eventId" text,
    "userId" uuid NOT NULL,
    summary text,
    notes text,
    "windowStartDate" timestamp without time zone NOT NULL,
    "windowEndDate" timestamp without time zone NOT NULL,
    timezone text,
    location jsonb,
    priority integer DEFAULT 1 NOT NULL,
    "sendUpdates" text DEFAULT 'all'::text,
    "guestsCanInviteOthers" boolean DEFAULT true NOT NULL,
    transparency text DEFAULT 'opaque'::text,
    visibility text DEFAULT 'default'::text,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "colorId" text,
    "backgroundColor" text,
    "foregroundColor" text,
    "useDefaultAlarms" boolean DEFAULT false NOT NULL,
    reminders jsonb,
    "cancelIfAnyRefuse" boolean DEFAULT false,
    "enableHostPreferences" boolean DEFAULT true,
    "enableAttendeePreferences" boolean DEFAULT true,
    "startDate" timestamp without time zone,
    "endDate" timestamp without time zone,
    "attendeeCount" integer DEFAULT 1,
    "expireDate" timestamp without time zone,
    "attendeeRespondedCount" integer DEFAULT 1,
    cancelled boolean DEFAULT false,
    duration integer DEFAULT 30,
    "enableConference" boolean DEFAULT false,
    "conferenceApp" text,
    "calendarId" text NOT NULL,
    "bufferTime" jsonb,
    "anyoneCanAddSelf" boolean DEFAULT true,
    "guestsCanSeeOtherGuests" boolean DEFAULT true,
    "minThresholdCount" integer,
    "allowAttendeeUpdatePreferences" boolean DEFAULT false,
    "guaranteeAvailability" boolean DEFAULT false,
    frequency text DEFAULT 'weekly'::text,
    "interval" integer DEFAULT 1,
    until timestamp without time zone,
    "originalMeetingId" uuid,
    "attendeeCanModify" boolean DEFAULT false
);
COMMENT ON TABLE public."Meeting_Assist" IS 'meeting assist for scheduling meetings using AI';
CREATE TABLE public."Meeting_Assist_Attendee" (
    id text NOT NULL,
    name text,
    "hostId" uuid NOT NULL,
    "userId" uuid DEFAULT gen_random_uuid() NOT NULL,
    emails jsonb,
    "contactId" text,
    "phoneNumbers" jsonb,
    "imAddresses" jsonb,
    "meetingId" uuid NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    timezone text,
    "externalAttendee" boolean DEFAULT false NOT NULL,
    "primaryEmail" text
);
COMMENT ON TABLE public."Meeting_Assist_Attendee" IS 'attendees for meeting assist using AI';
CREATE TABLE public."Meeting_Assist_Calendar" (
    id text NOT NULL,
    "attendeeId" text NOT NULL,
    title text,
    "backgroundColor" text,
    account jsonb,
    "accessLevel" text,
    modifiable boolean DEFAULT false NOT NULL,
    "defaultReminders" jsonb,
    resource text,
    "primary" boolean DEFAULT false,
    "colorId" text,
    "foregroundColor" text
);
COMMENT ON TABLE public."Meeting_Assist_Calendar" IS 'temporary calendar holder for meeting assist using AI';
CREATE TABLE public."Meeting_Assist_Comment" (
    id uuid NOT NULL,
    "userId" uuid NOT NULL,
    content text NOT NULL,
    "meetingId" uuid NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "replyId" uuid,
    username text NOT NULL,
    "profileId" uuid,
    avatar text
);
COMMENT ON TABLE public."Meeting_Assist_Comment" IS 'comments on new meeting assists using AI';
CREATE TABLE public."Meeting_Assist_Event" (
    id text NOT NULL,
    summary text,
    notes text,
    "startDate" timestamp without time zone DEFAULT now() NOT NULL,
    "endDate" timestamp without time zone DEFAULT now() NOT NULL,
    "allDay" boolean DEFAULT false NOT NULL,
    "recurrenceRule" jsonb,
    location jsonb,
    attachments jsonb,
    links jsonb,
    timezone text,
    transparency text,
    visibility text,
    "recurringEventId" text,
    "iCalUID" text,
    "htmlLink" text,
    "colorId" text,
    creator jsonb,
    organizer jsonb,
    "endTimeUnspecified" boolean DEFAULT false,
    recurrence jsonb,
    "attendeesOmitted" boolean DEFAULT false,
    "extendedProperties" jsonb,
    "hangoutLink" text,
    "guestsCanModify" boolean DEFAULT false,
    locked boolean DEFAULT false,
    source jsonb,
    "eventType" text,
    "privateCopy" boolean DEFAULT false,
    "calendarId" text NOT NULL,
    "backgroundColor" text,
    "foregroundColor" text,
    "useDefaultAlarms" boolean DEFAULT true,
    "externalUser" boolean DEFAULT true,
    "createdDate" timestamp with time zone DEFAULT now(),
    "updatedAt" timestamp with time zone DEFAULT now(),
    "attendeeId" text NOT NULL,
    "meetingId" uuid,
    "eventId" text
);
COMMENT ON TABLE public."Meeting_Assist_Event" IS 'temporary events holding for outside users for meeting assist';
CREATE TABLE public."Meeting_Assist_Invite" (
    id text NOT NULL,
    "hostId" uuid NOT NULL,
    email text,
    "hostName" text,
    "meetingId" uuid NOT NULL,
    name text NOT NULL,
    "createdDate" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "userId" uuid,
    response text DEFAULT 'PENDING'::text,
    "contactId" text
);
COMMENT ON TABLE public."Meeting_Assist_Invite" IS 'meeting assist invite links';
CREATE TABLE public."Meeting_Assist_Notification" (
    id uuid NOT NULL,
    "userId" uuid NOT NULL,
    "meetingId" uuid NOT NULL,
    content text NOT NULL,
    "commenterId" uuid NOT NULL,
    "commentId" uuid NOT NULL,
    "objectId" uuid,
    "commenterName" text NOT NULL,
    "scheduledTriggerId" text,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public."Meeting_Assist_Notification" IS 'meeting assist notifications';
CREATE TABLE public."Meeting_Assist_Preferred_Time_Range" (
    id uuid NOT NULL,
    "meetingId" uuid NOT NULL,
    "dayOfWeek" integer,
    "startTime" time without time zone NOT NULL,
    "endTime" time without time zone NOT NULL,
    "hostId" uuid NOT NULL,
    "attendeeId" text NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public."Meeting_Assist_Preferred_Time_Range" IS 'preferred times for meeting assist using AI';
CREATE TABLE public."PreferredTimeRange" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "eventId" text NOT NULL,
    "dayOfWeek" integer,
    "startTime" time without time zone NOT NULL,
    "endTime" time without time zone NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "userId" uuid NOT NULL
);
COMMENT ON TABLE public."PreferredTimeRange" IS 'preferred time ranges for event';
CREATE TABLE public."Relationship" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    label text NOT NULL,
    "contactId" text NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "userId" uuid NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public."Relationship" IS 'relationships to contacts';
CREATE TABLE public."Reminder" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "eventId" text NOT NULL,
    "userId" uuid NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "reminderDate" timestamp with time zone,
    timezone text,
    "updatedAt" timestamp with time zone DEFAULT now(),
    minutes integer,
    method text,
    "useDefault" boolean DEFAULT false
);
COMMENT ON TABLE public."Reminder" IS 'reminders for events';
CREATE TABLE public."Subscription" (
    id text NOT NULL,
    price text NOT NULL,
    currency text NOT NULL,
    "localizedPrice" text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    "introductoryPrice" text,
    "introductoryPriceAsAmount" text,
    "introductoryPricePaymentMode" text,
    "introductoryPriceNumberOfPeriods" integer,
    "introductoryPriceSubscriptionPeriod" text DEFAULT '"MONTH"'::text,
    "subscriptionPeriodNumber" integer DEFAULT 1 NOT NULL,
    "subscriptionPeriodUnit" text DEFAULT '"MONTH"'::text NOT NULL,
    device text DEFAULT '"ios"'::text NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "paymentMode" text
);
COMMENT ON TABLE public."Subscription" IS 'list of subscriptions available for purchasing';
CREATE TABLE public."Transaction" (
    id text NOT NULL,
    "subscriptionId" text NOT NULL,
    "subscriptionDate" timestamp with time zone,
    quantity integer DEFAULT 1 NOT NULL,
    "originalTransactionDate" timestamp with time zone,
    "originalTransactionId" text,
    "autoRenewingAndroid" boolean DEFAULT false,
    "dataAndroid" text,
    "signatureAndroid" text,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "userId" uuid NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "activeSubscriptionId" uuid,
    receipt text,
    refunded boolean DEFAULT false,
    "refundDate" timestamp with time zone
);
COMMENT ON TABLE public."Transaction" IS 'transactions for subscriptions';
CREATE TABLE public."User" (
    id uuid NOT NULL,
    email text,
    name text,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "userPreferenceId" uuid
);
CREATE TABLE public."User_Contact_Info" (
    id text NOT NULL,
    "userId" uuid NOT NULL,
    name text,
    type text DEFAULT 'email'::text NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "createdDate" timestamp with time zone DEFAULT now(),
    "primary" boolean DEFAULT false
);
COMMENT ON TABLE public."User_Contact_Info" IS 'alternative contact info for internal users either phone or email as id';
CREATE TABLE public."User_Preference" (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "userId" uuid NOT NULL,
    "createdDate" timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    "isPublicCalendar" boolean DEFAULT false NOT NULL,
    "publicCalendarCategories" jsonb,
    "updatedAt" timestamp with time zone DEFAULT now(),
    "startTimes" jsonb,
    "endTimes" jsonb,
    "copyAvailability" boolean,
    "copyTimeBlocking" boolean,
    "copyTimePreference" boolean,
    "copyReminders" boolean,
    "copyPriorityLevel" boolean,
    "copyModifiable" boolean,
    "copyCategories" boolean,
    "copyIsBreak" boolean,
    reminders jsonb,
    "followUp" jsonb,
    "maxWorkLoadPercent" integer DEFAULT 100,
    "maxNumberOfMeetings" integer DEFAULT 8,
    "backToBackMeetings" boolean DEFAULT false,
    "copyIsMeeting" boolean DEFAULT false,
    "copyIsExternalMeeting" boolean DEFAULT false,
    "onBoarded" boolean DEFAULT false,
    "copyColor" boolean DEFAULT false,
    "minNumberOfBreaks" integer DEFAULT 1,
    "breakLength" integer DEFAULT 20,
    "breakColor" text
);
COMMENT ON TABLE public."User_Preference" IS 'user preferences including for invites';
ALTER TABLE ONLY public."Active_Subscription"
    ADD CONSTRAINT "Active_Subscription_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Admin_Beta_Testing"
    ADD CONSTRAINT "Admin_Beta_Testing_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Admin"
    ADD CONSTRAINT "Admin_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Attendee"
    ADD CONSTRAINT "Attendee_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Autopilot"
    ADD CONSTRAINT "Autopilot_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Calendar_Integration"
    ADD CONSTRAINT "Calendar_Integration_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Calendar_Push_Notification"
    ADD CONSTRAINT "Calendar_Push_Notification_calendarId_key" UNIQUE ("calendarId");
ALTER TABLE ONLY public."Calendar_Push_Notification"
    ADD CONSTRAINT "Calendar_Push_Notification_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Calendar"
    ADD CONSTRAINT "Calendar_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Category_Event"
    ADD CONSTRAINT "Category_Event_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Conference"
    ADD CONSTRAINT "Conference_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Conference"
    ADD CONSTRAINT "Conference_requestId_key" UNIQUE ("requestId");
ALTER TABLE ONLY public."Contact_Event"
    ADD CONSTRAINT "Contact_Event_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Contact"
    ADD CONSTRAINT "Contact_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Event_Trigger"
    ADD CONSTRAINT "Event_Trigger_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Event"
    ADD CONSTRAINT "Event_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Feedback"
    ADD CONSTRAINT "Feedback_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Freemium"
    ADD CONSTRAINT "Freemium_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Freemium"
    ADD CONSTRAINT "Freemium_userId_key" UNIQUE ("userId");
ALTER TABLE ONLY public."GroupCalendar_GroupEvent"
    ADD CONSTRAINT "GroupCalendar_Event_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."GroupCalendar"
    ADD CONSTRAINT "GroupCalendar_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."GroupCategory_GroupEvent"
    ADD CONSTRAINT "GroupCategory_GroupEvent_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."GroupCategory"
    ADD CONSTRAINT "GroupCategory_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."GroupEvent"
    ADD CONSTRAINT "GroupEvent_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Group_User"
    ADD CONSTRAINT "Group_User_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Group"
    ADD CONSTRAINT "Group_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Invite"
    ADD CONSTRAINT "Invite_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Meeting_Assist_Attendee"
    ADD CONSTRAINT "Meeting_Assist_Attendee_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Meeting_Assist_Calendar"
    ADD CONSTRAINT "Meeting_Assist_Calendar_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Meeting_Assist_Comment"
    ADD CONSTRAINT "Meeting_Assist_Comment_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Meeting_Assist_Event"
    ADD CONSTRAINT "Meeting_Assist_Event_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Meeting_Assist_Invite"
    ADD CONSTRAINT "Meeting_Assist_Invite_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Meeting_Assist_Notification"
    ADD CONSTRAINT "Meeting_Assist_Notification_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Meeting_Assist_Preferred_Time_Range"
    ADD CONSTRAINT "Meeting_Assist_Preferred_Time_Ranges_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Meeting_Assist"
    ADD CONSTRAINT "Meeting_Assist_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."PreferredTimeRange"
    ADD CONSTRAINT "PreferredTimeRange_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Relationship"
    ADD CONSTRAINT "Relationship_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Reminder"
    ADD CONSTRAINT "Reminder_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Subscription"
    ADD CONSTRAINT "Subscription_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."User_Preference"
    ADD CONSTRAINT "UserPreference_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."User_Contact_Info"
    ADD CONSTRAINT "User_Contact_Info_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);
CREATE INDEX "Active_Subscription_transactionId_skey" ON public."Active_Subscription" USING btree ("transactionId");
CREATE INDEX "Active_Subscription_userId_skey" ON public."Active_Subscription" USING btree ("userId");
CREATE INDEX "Attendee_contactId_skey" ON public."Attendee" USING btree ("contactId");
CREATE INDEX "Attendee_eventId_skey" ON public."Attendee" USING btree ("eventId");
CREATE INDEX "Attendee_userId_skey" ON public."Attendee" USING btree ("userId");
CREATE INDEX "Autopilot_userId_skey" ON public."Autopilot" USING btree ("userId");
CREATE INDEX "Calendar_Integration_userId_skey" ON public."Calendar_Integration" USING btree ("userId");
CREATE INDEX "Calendar_Integration_zoomId_skey" ON public."Calendar_Integration" USING btree ("appId");
CREATE INDEX "Calendar_Push_Notification_userId_skey" ON public."Calendar_Push_Notification" USING btree ("userId");
CREATE INDEX "Calendar_userId_skey" ON public."Calendar" USING btree ("userId");
CREATE UNIQUE INDEX "Category_Event_categoryId_eventId_skey" ON public."Category_Event" USING btree ("categoryId", "eventId");
CREATE UNIQUE INDEX "Category_Event_eventId_categoryId_skey" ON public."Category_Event" USING btree ("eventId", "categoryId");
CREATE INDEX "Category_Event_userId_skey" ON public."Category_Event" USING btree ("userId");
CREATE INDEX "Category_userId_skey" ON public."Category" USING btree ("userId");
CREATE INDEX "Conference_userId_skey" ON public."Conference" USING btree ("userId");
CREATE UNIQUE INDEX "Contact_Event_contactId_eventId_skey" ON public."Contact_Event" USING btree ("contactId", "eventId");
CREATE UNIQUE INDEX "Contact_Event_eventId_contactId_skey" ON public."Contact_Event" USING btree ("eventId", "contactId");
CREATE INDEX "Contact_Event_userId_skey" ON public."Contact_Event" USING btree ("userId");
CREATE INDEX "Contact_userId_skey" ON public."Contact" USING btree ("userId");
CREATE UNIQUE INDEX "Event_Trigger_resourceId_skey" ON public."Event_Trigger" USING btree ("resourceId");
CREATE INDEX "Event_Trigger_userId_skey" ON public."Event_Trigger" USING btree ("userId");
CREATE INDEX "Event_calendarId_skey" ON public."Event" USING btree ("calendarId");
CREATE INDEX "Event_conferenceId_skey" ON public."Event" USING btree ("conferenceId");
CREATE UNIQUE INDEX "Event_eventId_calendarId_skey" ON public."Event" USING btree ("eventId", "calendarId");
CREATE INDEX "Event_userId_endDate_skey" ON public."Event" USING btree ("userId", "endDate");
CREATE INDEX "Event_userId_startDate_skey" ON public."Event" USING btree ("userId", "startDate");
CREATE INDEX "Feedback_userId_skey" ON public."Feedback" USING btree ("userId");
CREATE INDEX "Invite_contactId_skey" ON public."Invite" USING btree ("contactId");
CREATE INDEX "Invite_userId_skey" ON public."Invite" USING btree ("userId");
CREATE INDEX "Meeting_Assist_Attendee_meetingId_skey" ON public."Meeting_Assist_Attendee" USING btree ("meetingId");
CREATE INDEX "Meeting_Assist_Comment_meetingId_skey" ON public."Meeting_Assist_Comment" USING btree ("meetingId");
CREATE INDEX "Meeting_Assist_Event_attendeeId_endDate_skey" ON public."Meeting_Assist_Event" USING btree ("attendeeId", "endDate");
CREATE INDEX "Meeting_Assist_Event_attendeeId_startDate_skey" ON public."Meeting_Assist_Event" USING btree ("attendeeId", "startDate");
CREATE INDEX "Meeting_Assist_Event_calendarId_skey" ON public."Meeting_Assist_Event" USING btree ("calendarId");
CREATE INDEX "Meeting_Assist_Invite_hostId_skey" ON public."Meeting_Assist_Invite" USING btree ("hostId");
CREATE INDEX "Meeting_Assist_Invite_meetingId_skey" ON public."Meeting_Assist_Invite" USING btree ("meetingId");
CREATE INDEX "Meeting_Assist_Notification_meetingId" ON public."Meeting_Assist_Notification" USING btree ("meetingId");
CREATE INDEX "Meeting_Assist_Notification_userId" ON public."Meeting_Assist_Notification" USING btree ("userId");
CREATE INDEX "Meeting_Assist_Preferred_TIme_Ranges_meetingId_skey" ON public."Meeting_Assist_Preferred_Time_Range" USING btree ("meetingId");
CREATE INDEX "Meeting_Assist_originalMeetingId_skey" ON public."Meeting_Assist" USING btree ("originalMeetingId");
CREATE INDEX "Meeting_Assist_userId_startDate_endDate_skey" ON public."Meeting_Assist" USING btree ("userId", "windowStartDate", "windowEndDate");
CREATE INDEX "PreferredTimeRange_eventId_skey" ON public."PreferredTimeRange" USING btree ("eventId");
CREATE INDEX "Relationship_userId_contactId_skey" ON public."Relationship" USING btree ("userId", "contactId");
CREATE INDEX "Reminder_eventId_skey" ON public."Reminder" USING btree ("eventId");
CREATE INDEX "Reminder_userId_skey" ON public."Reminder" USING btree ("userId");
CREATE INDEX "Transaction_userId_skey" ON public."Transaction" USING btree ("userId");
CREATE UNIQUE INDEX "UserPreference_userId_skey" ON public."User_Preference" USING btree ("userId");
CREATE INDEX "User_Contact_info_userId_skey" ON public."User_Contact_Info" USING btree ("userId");
CREATE UNIQUE INDEX "emailId_inviteId_skey" ON public."Invite" USING btree ("emailId", id);
CREATE UNIQUE INDEX "phoneId_inviteId_skey" ON public."Invite" USING btree ("phoneId", id);
CREATE TRIGGER "set_public_Active_Subscription_updatedAt" BEFORE UPDATE ON public."Active_Subscription" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Active_Subscription_updatedAt" ON public."Active_Subscription" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Admin_Beta_Testing_updatedAt" BEFORE UPDATE ON public."Admin_Beta_Testing" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Admin_Beta_Testing_updatedAt" ON public."Admin_Beta_Testing" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Attendee_updatedAt" BEFORE UPDATE ON public."Attendee" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Attendee_updatedAt" ON public."Attendee" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Autopilot_updatedAt" BEFORE UPDATE ON public."Autopilot" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Autopilot_updatedAt" ON public."Autopilot" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Calendar_Integration_updatedAt" BEFORE UPDATE ON public."Calendar_Integration" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Calendar_Integration_updatedAt" ON public."Calendar_Integration" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Calendar_Push_Notification_updatedAt" BEFORE UPDATE ON public."Calendar_Push_Notification" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Calendar_Push_Notification_updatedAt" ON public."Calendar_Push_Notification" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Calendar_updatedAt" BEFORE UPDATE ON public."Calendar" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Calendar_updatedAt" ON public."Calendar" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Category_Event_updatedAt" BEFORE UPDATE ON public."Category_Event" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Category_Event_updatedAt" ON public."Category_Event" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Category_updatedAt" BEFORE UPDATE ON public."Category" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Category_updatedAt" ON public."Category" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Conference_updatedAt" BEFORE UPDATE ON public."Conference" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Conference_updatedAt" ON public."Conference" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Contact_Event_updatedAt" BEFORE UPDATE ON public."Contact_Event" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Contact_Event_updatedAt" ON public."Contact_Event" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Contact_updatedAt" BEFORE UPDATE ON public."Contact" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Contact_updatedAt" ON public."Contact" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Event_Trigger_updated_at" BEFORE UPDATE ON public."Event_Trigger" FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER "set_public_Event_Trigger_updated_at" ON public."Event_Trigger" IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER "set_public_Event_updatedAt" BEFORE UPDATE ON public."Event" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Event_updatedAt" ON public."Event" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Feedback_lastSeen" BEFORE UPDATE ON public."Feedback" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_lastSeen"();
COMMENT ON TRIGGER "set_public_Feedback_lastSeen" ON public."Feedback" IS 'trigger to set value of column "lastSeen" to current timestamp on row update';
CREATE TRIGGER "set_public_Feedback_updatedAt" BEFORE UPDATE ON public."Feedback" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Feedback_updatedAt" ON public."Feedback" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Freemium_updatedAt" BEFORE UPDATE ON public."Freemium" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Freemium_updatedAt" ON public."Freemium" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_GroupCalendar_GroupEvent_updatedAt" BEFORE UPDATE ON public."GroupCalendar_GroupEvent" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_GroupCalendar_GroupEvent_updatedAt" ON public."GroupCalendar_GroupEvent" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_GroupCalendar_updatedAt" BEFORE UPDATE ON public."GroupCalendar" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_GroupCalendar_updatedAt" ON public."GroupCalendar" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_GroupCategory_GroupEvent_updatedAt" BEFORE UPDATE ON public."GroupCategory_GroupEvent" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_GroupCategory_GroupEvent_updatedAt" ON public."GroupCategory_GroupEvent" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_GroupCategory_updatedAt" BEFORE UPDATE ON public."GroupCategory" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_GroupCategory_updatedAt" ON public."GroupCategory" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_GroupEvent_updatedAt" BEFORE UPDATE ON public."GroupEvent" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_GroupEvent_updatedAt" ON public."GroupEvent" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Group_User_updatedAt" BEFORE UPDATE ON public."Group_User" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Group_User_updatedAt" ON public."Group_User" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Group_updatedAt" BEFORE UPDATE ON public."Group" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Group_updatedAt" ON public."Group" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Invite_updatedAt" BEFORE UPDATE ON public."Invite" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Invite_updatedAt" ON public."Invite" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Meeting_Assist_Attendee_updatedAt" BEFORE UPDATE ON public."Meeting_Assist_Attendee" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Meeting_Assist_Attendee_updatedAt" ON public."Meeting_Assist_Attendee" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Meeting_Assist_Comment_updatedAt" BEFORE UPDATE ON public."Meeting_Assist_Comment" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Meeting_Assist_Comment_updatedAt" ON public."Meeting_Assist_Comment" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Meeting_Assist_Event_updatedAt" BEFORE UPDATE ON public."Meeting_Assist_Event" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Meeting_Assist_Event_updatedAt" ON public."Meeting_Assist_Event" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Meeting_Assist_Invite_updatedAt" BEFORE UPDATE ON public."Meeting_Assist_Invite" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Meeting_Assist_Invite_updatedAt" ON public."Meeting_Assist_Invite" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Meeting_Assist_Notification_updatedAt" BEFORE UPDATE ON public."Meeting_Assist_Notification" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Meeting_Assist_Notification_updatedAt" ON public."Meeting_Assist_Notification" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Meeting_Assist_Preferred_Time_Ranges_updatedAt" BEFORE UPDATE ON public."Meeting_Assist_Preferred_Time_Range" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Meeting_Assist_Preferred_Time_Ranges_updatedAt" ON public."Meeting_Assist_Preferred_Time_Range" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Meeting_Assist_updatedAt" BEFORE UPDATE ON public."Meeting_Assist" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Meeting_Assist_updatedAt" ON public."Meeting_Assist" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_PreferredTimeRange_updatedAt" BEFORE UPDATE ON public."PreferredTimeRange" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_PreferredTimeRange_updatedAt" ON public."PreferredTimeRange" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Relationship_updatedAt" BEFORE UPDATE ON public."Relationship" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Relationship_updatedAt" ON public."Relationship" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Reminder_updatedAt" BEFORE UPDATE ON public."Reminder" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Reminder_updatedAt" ON public."Reminder" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Subscription_updatedAt" BEFORE UPDATE ON public."Subscription" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Subscription_updatedAt" ON public."Subscription" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_Transaction_updatedAt" BEFORE UPDATE ON public."Transaction" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_Transaction_updatedAt" ON public."Transaction" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_UserPreference_updatedAt" BEFORE UPDATE ON public."User_Preference" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_UserPreference_updatedAt" ON public."User_Preference" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_User_Contact_Info_updatedAt" BEFORE UPDATE ON public."User_Contact_Info" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_User_Contact_Info_updatedAt" ON public."User_Contact_Info" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
CREATE TRIGGER "set_public_User_updatedAt" BEFORE UPDATE ON public."User" FOR EACH ROW EXECUTE FUNCTION public."set_current_timestamp_updatedAt"();
COMMENT ON TRIGGER "set_public_User_updatedAt" ON public."User" IS 'trigger to set value of column "updatedAt" to current timestamp on row update';
ALTER TABLE ONLY public."Active_Subscription"
    ADD CONSTRAINT "Active_Subscription_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public."Transaction"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Active_Subscription"
    ADD CONSTRAINT "Active_Subscription_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Attendee"
    ADD CONSTRAINT "Attendee_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Attendee"
    ADD CONSTRAINT "Attendee_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Autopilot"
    ADD CONSTRAINT "Autopilot_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Calendar_Integration"
    ADD CONSTRAINT "Calendar_Integration_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Calendar_Push_Notification"
    ADD CONSTRAINT "Calendar_Push_Notification_calendarId_fkey" FOREIGN KEY ("calendarId") REFERENCES public."Calendar"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Calendar_Push_Notification"
    ADD CONSTRAINT "Calendar_Push_Notification_calendarIntegrationId_fkey" FOREIGN KEY ("calendarIntegrationId") REFERENCES public."Calendar_Integration"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Calendar_Push_Notification"
    ADD CONSTRAINT "Calendar_Push_Notification_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Calendar"
    ADD CONSTRAINT "Calendar_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Category_Event"
    ADD CONSTRAINT "Category_Event_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Category_Event"
    ADD CONSTRAINT "Category_Event_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Category_Event"
    ADD CONSTRAINT "Category_Event_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Conference"
    ADD CONSTRAINT "Conference_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Contact_Event"
    ADD CONSTRAINT "Contact_Event_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES public."Contact"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Contact_Event"
    ADD CONSTRAINT "Contact_Event_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Contact_Event"
    ADD CONSTRAINT "Contact_Event_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Contact"
    ADD CONSTRAINT "Contact_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Event_Trigger"
    ADD CONSTRAINT "Event_Trigger_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Event"
    ADD CONSTRAINT "Event_calendarId_fkey" FOREIGN KEY ("calendarId") REFERENCES public."Calendar"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Event"
    ADD CONSTRAINT "Event_conferenceId_fkey" FOREIGN KEY ("conferenceId") REFERENCES public."Conference"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Event"
    ADD CONSTRAINT "Event_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Feedback"
    ADD CONSTRAINT "Feedback_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Freemium"
    ADD CONSTRAINT "Freemium_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."GroupCalendar_GroupEvent"
    ADD CONSTRAINT "GroupCalendar_Event_groupCalendarId_fkey" FOREIGN KEY ("groupCalendarId") REFERENCES public."GroupCalendar"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public."GroupCalendar_GroupEvent"
    ADD CONSTRAINT "GroupCalendar_Event_groupEventId_fkey" FOREIGN KEY ("groupEventId") REFERENCES public."GroupEvent"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public."GroupCalendar"
    ADD CONSTRAINT "GroupCalendar_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES public."Group"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public."GroupCategory_GroupEvent"
    ADD CONSTRAINT "GroupCategory_GroupEvent_groupCategoryId_fkey" FOREIGN KEY ("groupCategoryId") REFERENCES public."GroupCategory"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public."GroupCategory_GroupEvent"
    ADD CONSTRAINT "GroupCategory_GroupEvent_groupEventId_fkey" FOREIGN KEY ("groupEventId") REFERENCES public."GroupEvent"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public."GroupCategory"
    ADD CONSTRAINT "GroupCategory_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES public."Group"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public."GroupEvent"
    ADD CONSTRAINT "GroupEvent_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES public."Group"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public."Group_User"
    ADD CONSTRAINT "Group_User_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES public."Group"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public."Group_User"
    ADD CONSTRAINT "Group_User_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public."Invite"
    ADD CONSTRAINT "Invite_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES public."Contact"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Invite"
    ADD CONSTRAINT "Invite_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Meeting_Assist_Attendee"
    ADD CONSTRAINT "Meeting_Assist_Attendee_meetingId_fkey" FOREIGN KEY ("meetingId") REFERENCES public."Meeting_Assist"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Meeting_Assist_Calendar"
    ADD CONSTRAINT "Meeting_Assist_Calendar_attendeeId_fkey" FOREIGN KEY ("attendeeId") REFERENCES public."Meeting_Assist_Attendee"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Meeting_Assist_Comment"
    ADD CONSTRAINT "Meeting_Assist_Comment_meetingId_fkey" FOREIGN KEY ("meetingId") REFERENCES public."Meeting_Assist"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Meeting_Assist_Comment"
    ADD CONSTRAINT "Meeting_Assist_Comment_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Meeting_Assist_Event"
    ADD CONSTRAINT "Meeting_Assist_Event_attendeeId_fkey" FOREIGN KEY ("attendeeId") REFERENCES public."Meeting_Assist_Attendee"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Meeting_Assist_Invite"
    ADD CONSTRAINT "Meeting_Assist_Invite_meetingId_fkey" FOREIGN KEY ("meetingId") REFERENCES public."Meeting_Assist"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Meeting_Assist_Preferred_Time_Range"
    ADD CONSTRAINT "Meeting_Assist_Preferred_Time_Range_attendeeId_fkey" FOREIGN KEY ("attendeeId") REFERENCES public."Meeting_Assist_Attendee"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Meeting_Assist"
    ADD CONSTRAINT "Meeting_Assist_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."PreferredTimeRange"
    ADD CONSTRAINT "PreferredTimeRange_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Relationship"
    ADD CONSTRAINT "Relationship_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES public."Contact"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Reminder"
    ADD CONSTRAINT "Reminder_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Reminder"
    ADD CONSTRAINT "Reminder_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT "Transaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."User_Contact_Info"
    ADD CONSTRAINT "User_Contact_Info_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."User_Preference"
    ADD CONSTRAINT "User_Preference_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;
