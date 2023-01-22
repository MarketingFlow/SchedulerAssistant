import { gql } from "@apollo/client";

export default gql`
mutation UpdateCalendarDropGlobalPrimary($id: String!) {
  update_Calendar_by_pk(pk_columns: {id: $id}, _set: {globalPrimary: false}) {
    accessLevel
    account
    backgroundColor
    colorId
    createdDate
    defaultReminders
    deleted
    foregroundColor
    globalPrimary
    id
    modifiable
    resource
    title
    updatedAt
    userId
    pageToken
    syncToken
  }
}
`