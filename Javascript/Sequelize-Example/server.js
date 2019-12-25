const db = require('./db');

async function db_sync(db) {
  await db.sequelize
    .sync({})
    .then(() => {
      console.log('Succesfully synced the models to the database.');
    })
    .catch(err => {
      console.error('Unable to sync the models to the database:', err);
    });
}

async function authenticate(db) {
  await db.sequelize
    .authenticate()
    .then(() => {
      console.log('Connection has been established successfully.');
    })
    .catch(err => {
      console.error('Unable to connect to the database:', err);
    });
}

async function create_user_dduck(db) {
  await db.User
    .findOrCreate({
      where: {
        firstName: 'Donald',
        lastName: 'Duck'
      },
      defaults: {
        firstName: 'Donald',
        lastName: 'Duck',
        email: 'dduck@somewhere.com'
      }
    })
    .then(([user, created]) => {
      console.log(user.get({
        plain: true
      }))
      console.log(`created: ${created}`)
    })
}

async function find_all_users(db) {
  let users = []

  await db.User
    .findAll()
    .then(result => {
      users = result
      users.map(console.log);
    })
}

async function main() {
  console.log("Authentication check...");
  await authenticate(db)
  console.log("sync the models...");
  await db_sync(db)
  console.log("Create user...");
  await create_user_dduck(db)
  console.log("Find all users...");
  await find_all_users(db)
  console.log("Clean up after ourselves...");
  await db.sequelize.close()
}

// Call start
(async () => {
  console.log('before main');

  await main();

  console.log('after main');
})();

/* 
Clean up sequence:
DROP TABLE comments
DROP TABLE postTags
DROP TABLE tags
DROP TABLE posts
DROP TABLE users
*/