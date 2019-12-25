'use strict';

const Sequelize = require('sequelize');
const PostModel = require('./models/post.js');
const UserModel = require('./models/user.js');
const TagModel = require('./models/tag.js');
const CommentModel = require('./models/comment.js');
const backend = 'POSTGRES';
let sequelize = undefined;
let db_name = undefined
let username = undefined
let password = undefined

switch (backend) {
  case 'MSSQL':
    // Setup for MS SQL Server
    db_name = 'tempdb'
    username = 'sa'
    password = 'yourStrong(!)Password'
    sequelize = new Sequelize(db_name, username, password, {
      host: 'localhost',
      port: 1433,
      dialect: 'mssql',
      dialectOptions: {
        authentication: {
          type: 'default',
          options: {
            userName: username,
            password: password
          }
        }
      }
    });

    break;
  case 'POSTGRES':
    // Setup for PostgresSQL
    db_name = 'mdtest'
    username = 'postgres'
    password = 'mysecretpassword'
    sequelize = new Sequelize(db_name, username, password, {
      host: 'localhost',
      dialect: 'postgres'
    });

    break;
  case 'AZURE':
    // Setup for Azure SQL
    db_name = '<db name>'
    username = '<user name>'
    password = '<password>'
    sequelize = new Sequelize(db_name, username, password, {
      host: '<server>database.windows.net',
      port: 1433,
      dialect: 'mssql',
      dialectOptions: {
        options: {
          encrypt: true
        },
        authentication: {
          type: 'default',
          options: {
            userName: username,
            password: password
          }
        }
      }
    });

    break;
  default:
    throw `Backend: ${backend} is not supported!`;
}

const Post = PostModel(sequelize, Sequelize);
const User = UserModel(sequelize, Sequelize);
const Tag = TagModel(sequelize, Sequelize);
const Comment = CommentModel(sequelize, Sequelize);

Post.belongsTo(User, {
  as: 'author'
});

Post.hasMany(Comment);

Post.belongsToMany(Tag, {
  through: 'postTags'
});

User.hasMany(Post, {
  foreignKey: 'authorId'
});

User.hasMany(Comment, {
  foreignKey: 'authorId'
});

Tag.belongsToMany(Post, {
  through: 'postTags'
});

Comment.belongsTo(User, {
  as: 'author'
});

Comment.belongsTo(Post);

Comment.belongsTo(Comment, {
  as: 'parent'
});

Comment.hasMany(Comment, {
  foreignKey: 'parentId',
  as: 'response'
});

module.exports = {
  sequelize,
  Sequelize,
  Post,
  User,
  Tag,
  Comment
}
