import { v4 as uuid } from 'uuid'

import { dayjs } from '@app/date-utils'



import { contactEmail, contactPhone, ContactType, imAddress, linkAddress } from '@app/dataTypes/ContactType'
import { ApolloClient, NormalizedCacheObject, gql } from '@apollo/client';
import listContactsByUser from '@app/apollo/gql/listContactsByUser'
import deleteContactById from '@app/apollo/gql/deleteContactById'
import searchContactsByNameQuery from '@app/apollo/gql/searchContactsByNameQuery'
import { UserContactInfoType } from '@dataTypes/UserContactInfoType';
import insertUserContactInfoOne from '@app/apollo/gql/insertUserContactInfoOne';
import listUserContactInfosByUserId from '@app/apollo/gql/listUserContactInfosByUserId';
import { Dispatch, SetStateAction } from 'react';
import _ from 'lodash';
import upsertUserContactInfoItems from '@app/apollo/gql/upsertUserContactInfoItems';
import deleteUserContactInfoItems from '@app/apollo/gql/deleteUserContactInfoItems';

export const deleteContactInfoItems = async (
  client: ApolloClient<NormalizedCacheObject>,
  itemIds: string[],
) => {
  try {
    const deleteContactInfoItems = (await client.mutate<{ User_Contact_Info: UserContactInfoType[] }>({
      mutation: deleteUserContactInfoItems,
      variables: {
        itemIds,
      },
      fetchPolicy: 'no-cache',
    }))?.data?.User_Contact_Info


  } catch (e) {

  }
}

export const upsertContactInfoItems = async (
  client: ApolloClient<NormalizedCacheObject>,
  contactInfos: UserContactInfoType[],
) => {
  try {
    const affectedRows = (await client.mutate<{ insert_User_Contact_Info: { affected_rows: number, returning: UserContactInfoType[] } }>({
      mutation: upsertUserContactInfoItems,
      variables: {
        contactInfoItems: contactInfos?.map(c => (_.omit(c, ['__typename']))),
      },
      fetchPolicy: 'no-cache',
      update(cache, { data }) {


        cache.modify({
          fields: {
            User_Contact_Info(existingUserContactInfoItems = []) {
              const newUserContactInfoRefs = data?.insert_User_Contact_Info?.returning?.map((i, inx) => cache.writeFragment({
                data: data?.insert_User_Contact_Info?.returning[inx],
                fragment: gql`
                        fragment NewUser_Contact_Info on User_Contact_Info {
                            createdDate
                            id
                            name
                            primary
                            type
                            updatedAt
                            userId
                          }
                        `
              }));
              const filteredEvents = existingUserContactInfoItems?.filter((i: UserContactInfoType) => (data?.insert_User_Contact_Info?.returning?.find(n => (n?.id === i?.id))))
              return [...filteredEvents, ...newUserContactInfoRefs];
            }
          }
        })
      }
    }))?.data?.insert_User_Contact_Info?.affected_rows


  } catch (e) {

  }
}

export const updateInfoItemTypeValue = (
  infoItem: UserContactInfoType,
  newItemIndex: number,
  newType: 'email' | 'phone',
  oldInfoItems: UserContactInfoType[],
  setInfoItems: Dispatch<SetStateAction<UserContactInfoType[]>>,
) => {
  if (!(newItemIndex > -1)) {

    return
  }

  const newInfoItem = { ...infoItem, type: newType }

  const newInfoItems = _.cloneDeep(oldInfoItems)

  const updatedNewInfoItems = newInfoItems.slice(
    0, newItemIndex
  )
    .concat([newInfoItem])
    .concat(newInfoItems.slice(newItemIndex + 1))

  setInfoItems(updatedNewInfoItems)
}

export const updateInfoItemIdValue = (
  infoItem: UserContactInfoType,
  newItemIndex: number,
  newId: string,
  oldInfoItems: UserContactInfoType[],
  setInfoItems: Dispatch<SetStateAction<UserContactInfoType[]>>,
) => {
  if (!(newItemIndex > -1)) {

    return
  }

  const newInfoItem = { ...infoItem, id: newId }

  const newInfoItems = _.cloneDeep(oldInfoItems)

  const updatedNewInfoItems = newInfoItems.slice(
    0, newItemIndex
  )
    .concat([newInfoItem])
    .concat(newInfoItems.slice(newItemIndex + 1))

  setInfoItems(updatedNewInfoItems)
}

export const updateInfoItemNameValue = (
  infoItem: UserContactInfoType,
  newItemIndex: number,
  newName: string,
  oldInfoItems: UserContactInfoType[],
  setInfoItems: Dispatch<SetStateAction<UserContactInfoType[]>>,
) => {
  if (!(newItemIndex > -1)) {

    return
  }

  const newInfoItem = { ...infoItem, name: newName }

  const newInfoItems = _.cloneDeep(oldInfoItems)

  const updatedNewInfoItems = newInfoItems.slice(
    0, newItemIndex
  )
    .concat([newInfoItem])
    .concat(newInfoItems.slice(newItemIndex + 1))

  setInfoItems(updatedNewInfoItems)
}

export const updateInfoItemPrimaryValue = (
  infoItem: UserContactInfoType,
  newItemIndex: number,
  newPrimary: boolean,
  oldInfoItems: UserContactInfoType[],
  setInfoItems: Dispatch<SetStateAction<UserContactInfoType[]>>,
) => {
  if (!(newItemIndex > -1)) {

    return
  }

  const newInfoItem = { ...infoItem, primary: newPrimary }

  const foundIndex = oldInfoItems?.findIndex(o => (o?.primary))

  let newInfoItems: UserContactInfoType[] = []

  if (foundIndex > -1) {
    const foundOldItem = oldInfoItems?.[foundIndex]

    const oldClonedInfoItems = _.cloneDeep(oldInfoItems)

    const oldItemUpdatedInfoItems = oldClonedInfoItems.slice(
      0, foundIndex
    )
      .concat([{ ...foundOldItem, primary: !(foundOldItem?.primary) }])
      .concat(oldClonedInfoItems?.slice(foundIndex + 1))

    newInfoItems = _.cloneDeep(oldItemUpdatedInfoItems)
  } else {

    newInfoItems = _.cloneDeep(oldInfoItems)
  }



  const updatedNewInfoItems = newInfoItems.slice(
    0, newItemIndex
  )
    .concat([newInfoItem])
    .concat(newInfoItems.slice(newItemIndex + 1))

  setInfoItems(updatedNewInfoItems)
}

export const removeInfoItemToItems = (
  index: number,
  infoItems: UserContactInfoType[],
  setInfoItems: Dispatch<SetStateAction<UserContactInfoType[]>>,
) => {
  const newInfoItems = infoItems.slice(0, index)
    .concat(infoItems.slice(index + 1))

  setInfoItems(newInfoItems)
  return newInfoItems
}

export const addInfoItemToItems = (
  infoItem: UserContactInfoType,
  infoItems: UserContactInfoType[],
  setInfoItems: Dispatch<SetStateAction<UserContactInfoType[]>>,
) => {

  const newInfoItems = [infoItem].concat(infoItems)
  setInfoItems(newInfoItems)

}

export const listUserContactInfosGivenUserId = async (
  client: ApolloClient<NormalizedCacheObject>,
  userId: string,
) => {
  try {
    const results = (await client.query<{ User_Contact_Info: UserContactInfoType[] }>({
      query: listUserContactInfosByUserId,
      variables: {
        userId,
      },
      fetchPolicy: 'no-cache',
    }))?.data?.User_Contact_Info



    return results

  } catch (e) {

  }
}

export const addUserContactInfo = async (
  client: ApolloClient<NormalizedCacheObject>,
  contactInfo: UserContactInfoType,
) => {
  try {
    const variables = {
      contactInfo,
    }

    const contactInfoDoc = (await client.mutate<{ insert_User_Contact_Info_one: UserContactInfoType }>({
      mutation: insertUserContactInfoOne,
      variables: variables,
    }))?.data?.insert_User_Contact_Info_one



    return contactInfoDoc

  } catch (e) {

  }
}

export const createContact = async (
  client: ApolloClient<NormalizedCacheObject>,
  userId: string,
  imageAvailable: boolean,
  name?: string,
  firstName?: string,
  middleName?: string,
  lastName?: string,
  maidenName?: string,
  namePrefix?: string,
  nameSuffix?: string,
  nickname?: string,
  phoneticFirstName?: string,
  phoneticMiddleName?: string,
  phoneticLastName?: string,
  company?: string,
  jobTitle?: string,
  department?: string,
  notes?: string,
  contactType?: string,
  emails?: contactEmail[],
  phoneNumbers?: contactPhone[],
  imAddresses?: imAddress[],
  linkAddresses?: linkAddress[],
  app?: string,
) => {
  try {
    const upsertContactMutation = gql`
    mutation InsertContact($contacts: [Contact_insert_input!]!) {
      insert_Contact(
          objects: $contacts,
          on_conflict: {
              constraint: Contact_pkey,
              update_columns: [
                ${name ? 'name,' : ''} 
                ${firstName ? 'firstName,' : ''} 
                ${middleName ? 'middleName,' : ''}
              ${lastName ? 'lastName,' : ''}
              ${maidenName ? 'maidenName,' : ''}
              ${namePrefix ? 'namePrefix,' : ''}
              ${nameSuffix ? 'nameSuffix,' : ''}
              ${nickname ? 'nickname,' : ''}
              ${phoneticFirstName ? 'phoneticFirstName,' : ''}
              ${phoneticMiddleName ? 'phoneticMiddleName,' : ''}
              ${phoneticLastName ? 'phoneticLastName,' : ''}
              ${company ? 'company,' : ''}
              ${jobTitle ? 'jobTitle,' : ''}
              ${department ? 'department,' : ''}
              ${notes ? 'notes,' : ''}
              ${imageAvailable !== undefined ? 'imageAvailable,' : ''}
              ${contactType ? 'contactType,' : ''}
              ${emails?.length > 0 ? 'emails,' : ''}
              ${phoneNumbers?.length > 0 ? 'phoneNumbers,' : ''}
              ${imAddresses?.length > 0 ? 'imAddresses,' : ''}
              ${linkAddresses?.length > 0 ? 'linkAddresses,' : ''}
              ${app ? 'app,' : ''}
              deleted,
              updatedAt,
            ]
          }){
          returning {
            id
          }
        }
      }
    `
    const id = uuid()
    let valueToUpsert: any = {
      id,
      userId,
    }

    if (name) {
      valueToUpsert = {
        ...valueToUpsert,
        name,
      }
    }

    if (firstName) {
      valueToUpsert = {
        ...valueToUpsert,
        firstName,
      }
    }

    if (middleName) {
      valueToUpsert = {
        ...valueToUpsert,
        middleName,
      }
    }

    if (lastName) {
      valueToUpsert = {
        ...valueToUpsert,
        lastName,
      }
    }

    if (maidenName) {
      valueToUpsert = {
        ...valueToUpsert,
        maidenName,
      }
    }

    if (namePrefix) {
      valueToUpsert = {
        ...valueToUpsert,
        namePrefix,
      }
    }

    if (nameSuffix) {
      valueToUpsert = {
        ...valueToUpsert,
        nameSuffix,
      }
    }

    if (nickname) {
      valueToUpsert = {
        ...valueToUpsert,
        nickname,
      }
    }

    if (phoneticFirstName) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneticFirstName,
      }
    }

    if (phoneticMiddleName) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneticMiddleName,
      }
    }

    if (phoneticLastName) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneticLastName,
      }
    }

    if (company) {
      valueToUpsert = {
        ...valueToUpsert,
        company,
      }
    }

    if (jobTitle) {
      valueToUpsert = {
        ...valueToUpsert,
        jobTitle,
      }
    }

    if (department) {
      valueToUpsert = {
        ...valueToUpsert,
        department,
      }
    }

    if (notes) {
      valueToUpsert = {
        ...valueToUpsert,
        notes,
      }
    }

    if (imageAvailable !== undefined) {
      valueToUpsert = {
        ...valueToUpsert,
        imageAvailable,
      }
    }

    if (contactType) {
      valueToUpsert = {
        ...valueToUpsert,
        contactType,
      }
    }

    if (emails?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        emails,
      }
    }

    if (phoneNumbers?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneNumbers,
      }
    }

    if (imAddresses?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        imAddresses,
      }
    }

    if (linkAddresses?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        linkAddresses,
      }
    }

    if (app) {
      valueToUpsert = {
        ...valueToUpsert,
        app,
      }
    }

    valueToUpsert = {
      ...valueToUpsert,
      updatedAt: dayjs().toISOString(),
      createdDate: dayjs().toISOString(),
      deleted: false,
    }

    const { data } = await client.mutate<{ insert_Contact: { returning: ContactType[] } }>({
      mutation: upsertContactMutation,
      variables: {
        contacts: [valueToUpsert],
      },
    })

    return data.insert_Contact.returning[0]
  } catch (e) {

  }
}

export const upsertContact = async (
  client: ApolloClient<NormalizedCacheObject>,
  userId: string,
  id: string,
  imageAvailable?: boolean | null,
  name?: string | null,
  firstName?: string | null,
  middleName?: string | null,
  lastName?: string | null,
  maidenName?: string | null,
  namePrefix?: string | null,
  nameSuffix?: string | null,
  nickname?: string | null,
  phoneticFirstName?: string | null,
  phoneticMiddleName?: string | null,
  phoneticLastName?: string | null,
  company?: string | null,
  jobTitle?: string | null,
  department?: string | null,
  notes?: string | null,
  contactType?: string | null,
  emails?: contactEmail[] | null,
  phoneNumbers?: contactPhone[] | null,
  imAddresses?: imAddress[] | null,
  linkAddresses?: linkAddress[] | null,
  app?: string | null,
) => {
  try {
    const upsertContactMutation = gql`
    mutation InsertContact($contacts: [Contact_insert_input!]!) {
      insert_Contact(
          objects: $contacts,
          on_conflict: {
              constraint: Contact_pkey,
              update_columns: [
                ${name ? 'name,' : ''} 
                ${firstName ? 'firstName,' : ''} 
                ${middleName ? 'middleName,' : ''}
              ${lastName ? 'lastName,' : ''}
              ${maidenName ? 'maidenName,' : ''}
              ${namePrefix ? 'namePrefix,' : ''}
              ${nameSuffix ? 'nameSuffix,' : ''}
              ${nickname ? 'nickname,' : ''}
              ${phoneticFirstName ? 'phoneticFirstName,' : ''}
              ${phoneticMiddleName ? 'phoneticMiddleName,' : ''}
              ${phoneticLastName ? 'phoneticLastName,' : ''}
              ${company ? 'company,' : ''}
              ${jobTitle ? 'jobTitle,' : ''}
              ${department ? 'department,' : ''}
              ${notes ? 'notes,' : ''}
              ${imageAvailable !== undefined ? 'imageAvailable,' : ''}
              ${contactType ? 'contactType,' : ''}
              ${emails?.length > 0 ? 'emails,' : ''}
              ${phoneNumbers?.length > 0 ? 'phoneNumbers,' : ''}
              ${imAddresses?.length > 0 ? 'imAddresses,' : ''}
              ${linkAddresses?.length > 0 ? 'linkAddresses,' : ''}
              ${app ? 'app,' : ''}
              deleted,
              updatedAt,
            ]
          }){
          returning {
            id
          }
        }
      }
    `
    let valueToUpsert: any = {
      id,
      userId,
    }

    if (name) {
      valueToUpsert = {
        ...valueToUpsert,
        name,
      }
    }

    if (firstName) {
      valueToUpsert = {
        ...valueToUpsert,
        firstName,
      }
    }

    if (middleName) {
      valueToUpsert = {
        ...valueToUpsert,
        middleName,
      }
    }

    if (lastName) {
      valueToUpsert = {
        ...valueToUpsert,
        lastName,
      }
    }

    if (maidenName) {
      valueToUpsert = {
        ...valueToUpsert,
        maidenName,
      }
    }

    if (namePrefix) {
      valueToUpsert = {
        ...valueToUpsert,
        namePrefix,
      }
    }

    if (nameSuffix) {
      valueToUpsert = {
        ...valueToUpsert,
        nameSuffix,
      }
    }

    if (nickname) {
      valueToUpsert = {
        ...valueToUpsert,
        nickname,
      }
    }

    if (phoneticFirstName) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneticFirstName,
      }
    }

    if (phoneticMiddleName) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneticMiddleName,
      }
    }

    if (phoneticLastName) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneticLastName,
      }
    }

    if (company) {
      valueToUpsert = {
        ...valueToUpsert,
        company,
      }
    }

    if (jobTitle) {
      valueToUpsert = {
        ...valueToUpsert,
        jobTitle,
      }
    }

    if (department) {
      valueToUpsert = {
        ...valueToUpsert,
        department,
      }
    }

    if (notes) {
      valueToUpsert = {
        ...valueToUpsert,
        notes,
      }
    }

    if (imageAvailable !== undefined) {
      valueToUpsert = {
        ...valueToUpsert,
        imageAvailable,
      }
    }

    if (contactType) {
      valueToUpsert = {
        ...valueToUpsert,
        contactType,
      }
    }

    if (emails?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        emails,
      }
    }

    if (phoneNumbers?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneNumbers,
      }
    }

    if (imAddresses?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        imAddresses,
      }
    }

    if (linkAddresses?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        linkAddresses,
      }
    }

    if (app) {
      valueToUpsert = {
        ...valueToUpsert,
        app,
      }
    }

    valueToUpsert = {
      ...valueToUpsert,
      updatedAt: dayjs().toISOString(),
      createdDate: dayjs().toISOString(),
      deleted: false,
    }

    const { data } = await client.mutate<{ insert_Contact: { returning: ContactType[] } }>({
      mutation: upsertContactMutation,
      variables: {
        contacts: [valueToUpsert],
      },
    })

    return data.insert_Contact.returning[0]
  } catch (e) {

  }
}

export const searchContactsByName = async (
  client: ApolloClient<NormalizedCacheObject>,
  userId: string,
  name: string,
): Promise<ContactType[] | []> => {
  try {
    const formattedName = `%${name}%`


    const results = (await client.query<{ Contact: ContactType[] }>({
      query: searchContactsByNameQuery,
      variables: {
        userId,
        name: formattedName,
      },
      fetchPolicy: 'no-cache',
    }))?.data?.Contact


    return results
  } catch (e) {

    return []
  }
}

export const listUserContactsHelper = async (
  client: ApolloClient<NormalizedCacheObject>,
  userId: string,
) => {
  try {

    const results = (await client.query<{ Contact: ContactType[] }>({
      query: listContactsByUser,
      variables: {
        userId,
      },
      fetchPolicy: 'no-cache',
    }))?.data?.Contact


    return results
  } catch (e) {

  }
}

// for search concat "%" like "%amet%"

export const updateContact = async (
  client: ApolloClient<NormalizedCacheObject>,
  contactId: string,
  imageAvailable?: boolean,
  name?: string,
  firstName?: string,
  middleName?: string,
  lastName?: string,
  maidenName?: string,
  namePrefix?: string,
  nameSuffix?: string,
  nickname?: string,
  phoneticFirstName?: string,
  phoneticMiddleName?: string,
  phoneticLastName?: string,
  company?: string,
  jobTitle?: string,
  department?: string,
  notes?: string,
  contactType?: string,
  emails?: contactEmail[],
  phoneNumbers?: contactPhone[],
  imAddresses?: imAddress[],
  linkAddresses?: linkAddress[],
  app?: string,
) => {
  try {
    const upsertContactMutation = gql`
    mutation InsertContact($contacts: [Contact_insert_input!]!) {
      insert_Contact(
          objects: $contacts,
          on_conflict: {
              constraint: Contact_pkey,
              update_columns: [
                ${name ? 'name,' : ''} 
                ${firstName ? 'firstName,' : ''} 
                ${middleName ? 'middleName,' : ''}
                ${lastName ? 'lastName,' : ''}
                ${maidenName ? 'maidenName,' : ''}
                ${namePrefix ? 'namePrefix,' : ''}
                ${nameSuffix ? 'nameSuffix,' : ''}
                ${nickname ? 'nickname,' : ''}
                ${phoneticFirstName ? 'phoneticFirstName,' : ''}
                ${phoneticMiddleName ? 'phoneticMiddleName,' : ''}
                ${phoneticLastName ? 'phoneticLastName,' : ''}
                ${company ? 'company,' : ''}
                ${jobTitle ? 'jobTitle,' : ''}
                ${department ? 'department,' : ''}
                ${notes ? 'notes,' : ''}
                ${imageAvailable !== undefined ? 'imageAvailable,' : ''}
                ${contactType ? 'contactType,' : ''}
                ${emails?.length > 0 ? 'emails,' : ''}
                ${phoneNumbers?.length > 0 ? 'phoneNumbers,' : ''}
                ${imAddresses?.length > 0 ? 'imAddresses,' : ''}
                ${linkAddresses?.length > 0 ? 'linkAddresses,' : ''}
                ${app ? 'app,' : ''}
                updatedAt,
            ]
          }){
          returning {
            id
          }
        }
      }
    `
    let valueToUpsert: any = {
      id: contactId,
    }

    if (name) {
      valueToUpsert = {
        ...valueToUpsert,
        name,
      }
    }

    if (firstName) {
      valueToUpsert = {
        ...valueToUpsert,
        firstName,
      }
    }

    if (middleName) {
      valueToUpsert = {
        ...valueToUpsert,
        middleName,
      }
    }

    if (lastName) {
      valueToUpsert = {
        ...valueToUpsert,
        lastName,
      }
    }

    if (maidenName) {
      valueToUpsert = {
        ...valueToUpsert,
        maidenName,
      }
    }

    if (namePrefix) {
      valueToUpsert = {
        ...valueToUpsert,
        namePrefix,
      }
    }

    if (nameSuffix) {
      valueToUpsert = {
        ...valueToUpsert,
        nameSuffix,
      }
    }

    if (nickname) {
      valueToUpsert = {
        ...valueToUpsert,
        nickname,
      }
    }

    if (phoneticFirstName) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneticFirstName,
      }
    }

    if (phoneticMiddleName) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneticMiddleName,
      }
    }

    if (phoneticLastName) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneticLastName,
      }
    }

    if (company) {
      valueToUpsert = {
        ...valueToUpsert,
        company,
      }
    }

    if (jobTitle) {
      valueToUpsert = {
        ...valueToUpsert,
        jobTitle,
      }
    }

    if (department) {
      valueToUpsert = {
        ...valueToUpsert,
        department,
      }
    }

    if (notes) {
      valueToUpsert = {
        ...valueToUpsert,
        notes,
      }
    }

    if (imageAvailable !== undefined) {
      valueToUpsert = {
        ...valueToUpsert,
        imageAvailable,
      }
    }

    if (contactType) {
      valueToUpsert = {
        ...valueToUpsert,
        contactType,
      }
    }

    if (emails?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        emails,
      }
    }

    if (phoneNumbers?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        phoneNumbers,
      }
    }

    if (imAddresses?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        imAddresses,
      }
    }

    if (linkAddresses?.length > 0) {
      valueToUpsert = {
        ...valueToUpsert,
        linkAddresses,
      }
    }

    if (app) {
      valueToUpsert = {
        ...valueToUpsert,
        app,
      }
    }

    valueToUpsert = {
      ...valueToUpsert,
      updatedAt: dayjs().toISOString(),
    }

    const { data } = await client.mutate<{ insert_Contact: { returning: ContactType[] } }>({
      mutation: upsertContactMutation,
      variables: {
        contacts: [valueToUpsert],
      },
    })

    return data.insert_Contact.returning[0]
  } catch (e) {

  }
}

export const deleteContact = async (
  client: ApolloClient<NormalizedCacheObject>,
  contactId: string,
) => {
  try {
    const { data } = await client.mutate<{ delete_Contact_by_pk: ContactType }>({
      mutation: deleteContactById,
      variables: {
        id: contactId,
      },
    })

  } catch (e) {

  }
}


/** end */
