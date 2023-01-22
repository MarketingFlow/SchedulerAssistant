
import { Auth } from '@aws-amplify/auth'
import { dayjs } from '@app/date-utils'

import {
  hasuraApiUrl,
} from '@app/lib/constants'
import { CalendarIntegrationType } from '@dataTypes/calendar_integrationType'
import { ApolloClient, gql, NormalizedCacheObject } from '@apollo/client'

// dayjs.extend(utc)

export const updateCalendarIntegration = async (
  client: ApolloClient<NormalizedCacheObject>,
  calIntegId: string,
  enabled?: boolean,
  token?: string,
  refreshToken?: string,
  expiresAt?: string,
  clientType?: string,
) => {
  try {
    const updateCalendarIntegration = gql`
      mutation UpdateCalendarIntegrationById($id: uuid!, ${enabled !== undefined ? '$enabled: Boolean,' : ''} ${expiresAt ? '$expiresAt: timestamptz,' : ''} ${refreshToken ? '$refreshToken: String,' : ''} ${token ? '$token: String,' : ''} $updatedAt: timestamptz) {
        update_Calendar_Integration_by_pk(_set: {${enabled !== undefined ? 'enabled: $enabled,' : ''} ${expiresAt ? 'expiresAt: $expiresAt,' : ''} ${refreshToken ? 'refreshToken: $refreshToken,' : ''} ${token ? 'token: $token,' : ''} updatedAt: $updatedAt}, pk_columns: {id: $id}) {
          appAccountId
          appEmail
          appId
          colors
          contactEmail
          contactName
          createdDate
          deleted
          enabled
          expiresAt
          id
          name
          pageToken
          password
          refreshToken
          syncEnabled
          resource
          token
          syncToken
          updatedAt
          userId
          username
          clientType
        }
      }
    `

    let variables: any = {
      id: calIntegId,
      updatedAt: dayjs().toISOString(),
    }

    if (enabled !== undefined) {
      variables.enabled = enabled
    }

    if (expiresAt) {
      variables.expiresAt = dayjs(expiresAt).toISOString()
    }

    if (refreshToken) {
      variables.refreshToken = refreshToken
    }

    if (token) {
      variables.token = token
    }

    if (clientType) {
      variables.clientType = clientType
    }

    const results = (await client.mutate<{ update_Calendar_Integration_by_pk: CalendarIntegrationType }>({
      mutation: updateCalendarIntegration,
      variables,
    })).data.update_Calendar_Integration_by_pk

    return results
  } catch (e) {

  }
}

/**
end
 */
