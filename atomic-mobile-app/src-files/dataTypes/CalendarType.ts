
type DefaultReminder = {
  method: string,
  minutes: number,
}


export type CalendarType = {
  __typename?: string
  id: string,
  title?: string,
  backgroundColor?: string,
  foregroundColor?: string,
  colorId?: string,
  account?: object,
  accessLevel?: string,
  resource?: string,
  modifiable?: boolean,
  defaultReminders?: DefaultReminder[],
  globalPrimary?: boolean,
  pageToken?: string,
  syncToken?: string,
  deleted: boolean,
  createdDate: string,
  updatedAt: string,
  userId: string,
}
