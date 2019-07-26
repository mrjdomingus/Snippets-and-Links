Given schema:
```js
enum Role @embedded {
  ADMIN
  GUEST
  UNASSIGNED
}

type User {
  id: ID! @id
  name: String!
  email: String! @unique
  password: String!
  roles: [Role!]!
}

type Mutation {
  createUser(data: UserCreateInput!): User!
}
```
Enter mutation like so:
```js
mutation {
  createUser(
    data: {
      name: "Marcel"
      email: "dominspm@xs4all.nl"
      password: "bigSecret"
      roles: { set: [ADMIN, GUEST] }
    }
  ) {
    name
  }
}

```
**Note**: enum values are entered without (double) quotes.
