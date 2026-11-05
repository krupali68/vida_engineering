import { createClient } from '@sanity/client'

export const client = createClient({
  projectId: 'ssxvdj5t',
  dataset: 'production',
  useCdn: true,
  apiVersion: '2026-11-04',
})

export async function getHomepage() {
  const query = `*[_type == "homepage"][0]`
  return await client.fetch(query)
}