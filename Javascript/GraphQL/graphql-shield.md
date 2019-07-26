# How to use graphql-shield

```js
const express = require('express');
const { ApolloServer, gql } = require("apollo-server-express");
const app = express();
const { shield, rule, allow, deny, and } = require("graphql-shield");
const { applyMiddleware } = require("graphql-middleware");
const { makeExecutableSchema } = require("graphql-tools");

const ADMIN_ROLE = "admin";

const isAuthenticated = rule({ cache: "contextual" })(
  async (parent, args, context, _info) => {
    console.log("context ->", context.user);
    const result = !(Object.entries(context.user).length === 0 && context.user.constructor === Object)
    console.info(`isAuthenticated:${result}`);
    return result;
  }
);

// permissions
const isAdmin = rule({ cache: "contextual" })(
  async (parent, args, context, _info) => {
    console.info("I reach here when I assumed it should be short circuited");
    // this line throws an exception because of context.user === null
    console.log("context --->", context.user);
    const result = context.user.role === ADMIN_ROLE;

    console.info(`isAdmin:${result}, but not here`);
    return result;
  }
);

// Construct a schema, using GraphQL schema language
const typeDefs = gql`
  type Query {
    hello: String
    user: [User!]
    privateResolver: Boolean!
  }

  type User {
    id: ID!
    name: String!
  }
`;

// Provide resolver functions for your schema fields
const resolvers = {
  Query: {
    privateResolver: (root, args, context) => {
      return true;
    },
    hello: (root, args, context) => "Hello world!",
    user: (root, args, context) => {
      return [
        {
          id: "1",
          name: "Foo"
        },
        {
          id: "2",
          name: "Bar"
        }
      ];
    }
  }
};

const permisions = shield({
  Query: {
    hello: allow,
    user: isAuthenticated,
    privateResolver: and(isAuthenticated, isAdmin)
  }
});

const schema = applyMiddleware(
  makeExecutableSchema({
    typeDefs,
    resolvers
  }),
  permisions
);

const server = new ApolloServer({
  typeDefs,
  resolvers,
  schema,
  context: ({ req }) => {
    return {
      // mocking that there is no user currently in the context
      user: { name: 'Marcel', role: ADMIN_ROLE }
    };
  }
});

server.applyMiddleware({ app });

app.get('/', function (req, res) {
  res.send('hello world')
})

app.listen({ port: 4000 }, () => {
  console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`);
});
```
