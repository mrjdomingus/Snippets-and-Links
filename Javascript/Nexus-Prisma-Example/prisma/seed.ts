import { prisma } from '../src/generated/prisma-client'

async function main() {
  await prisma.createUser({
    email: 'alice@prisma.io',
    name: 'Alice',
    posts: {
      create: {
        title: 'Join us for GraphQL Conf 2019 in Berlin',
        content: 'https://www.graphqlconf.org/',
        published: true,
      },
    },
  })
  await prisma.createUser({
    email: 'bob@prisma.io',
    name: 'Bob',
    posts: {
      create: [
        {
          title: 'Subscribe to GraphQL Weekly for community news',
          content: 'https://graphqlweekly.com/',
          published: true,
        },
        {
          title: 'Follow Prisma on Twitter',
          content: 'https://twitter.com/prisma',
        },
      ],
    },
  })
}

main().catch(e => console.error(e))
