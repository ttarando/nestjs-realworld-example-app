# ![Node/Express/Mongoose Example App](project-logo.png)

[![Build Status](https://travis-ci.org/anishkny/node-express-realworld-example-app.svg?branch=master)](https://travis-ci.org/anishkny/node-express-realworld-example-app)

> ### NestJS codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the [RealWorld](https://github.com/gothinkster/realworld-example-apps) API spec.


----------

# Getting started

## Installation

Clone the repository

    git clone https://github.com/lujakob/nestjs-realworld-example-app.git

Switch to the repo folder

    cd nestjs-realworld-example-app
    
Install dependencies
    
    npm install

Copy config file and set JsonWebToken secret key

    cp src/config.ts.example src/config.ts
    
----------

## Database

The codebase contains examples of two different database abstractions, namely [TypeORM](http://typeorm.io/) and [Prisma](https://www.prisma.io/). 
    
The branch `master` implements TypeORM with a mySQL database.

The branch `prisma` implements Prisma with a mySQL database.

----------

##### TypeORM

----------

Create a new mysql database with the name `nestjsrealworld`\
(or the name you specified in the ormconfig.json)

Copy TypeORM config example file for database settings

    cp ormconfig.json.example
    
Set mysql database settings in ormconfig.json

    {
      "type": "mysql",
      "host": "localhost",
      "port": 3306,
      "username": "your-mysql-username",
      "password": "your-mysql-password",
      "database": "nestjsrealworld",
      "entities": ["src/**/**.entity{.ts,.js}"],
      "synchronize": true
    }
    
Start local mysql server and create new database 'nestjsrealworld'

On application start, tables for all entities will be created.

----------

##### Prisma

----------

To run the example with Prisma checkout branch `prisma`, remove the node_modules and run `npm install`

Create a new mysql database with the name `nestjsrealworld-prisma` (or the name you specified in `prisma/.env`)

Copy prisma config example file for database settings

    cp prisma/.env.example prisma/.env

Set mysql database settings in prisma/.env

    DATABASE_URL="mysql://USER:PASSWORD@HOST:PORT/DATABASE"

To create all tables in the new database make the database migration from the prisma schema defined in prisma/schema.prisma

    npx prisma migrate save --experimental
    npx prisma migrate up --experimental

Now generate the prisma client from the migrated database with the following command

    npx prisma generate

The database tables are now set up and the prisma client is generated. For more information see the docs:

- https://www.prisma.io/docs/getting-started/setup-prisma/add-to-existing-project-typescript-mysql


----------

## NPM scripts

- `npm start` - Start application
- `npm run start:watch` - Start application in watch mode
- `npm run test` - run Jest test runner 
- `npm run start:prod` - Build application
- `npm run db:seed` - DB seeding

----------
## DB connection config via env variables
There are 5 env variables which can be used to configure DB connection string.
These are:
* `DB_HOST` - optional, default is 'localhost'
* `DB_PORT` - optional, default is 5432
* `DB_USER` - optional, default is 'postgres'
* `DB_PASS` - required, no default
* `DB_NAME` - optional, default is 'postgres'

### Starting service
1) export DB connection variables, in example:
    ```
    export DB_HOST=<host>> DB_PORT=5432 DB_USER=<user> DB_PASS=<pass> DB_NAME=<database>
    ```
2) run DB seed script
    ```
    npm start
    ```
   
----------
## DB Seeding
Start the API and once it's up and running open up another terminal and run the following:
1) export DB connection variables, in example:
    ```
    export DB_HOST=<host> DB_PORT=5432 DB_USER=<user> DB_PASS=<pass> DB_NAME=<database>
    ```
2) run DB seed script
    ```
    npm run db:seed
    ```

----------
## Manual building and running using Docker
### Build
```
docker build . -t realworld-example-api:latest
```
### Run
```
docker run -e DB_PASS=<your-db-pass> -e DB_HOST=<your-db-host> realworld-example-api
```

----------
## Local development using docker-compose
### DB only
```
docker-compose up postgres
```
### DB and App
```
docker-compose up api
```

----------
## Load test 
### Install Artillery
```
npm install -g artillery@1.6.0
```
### Run test
```
artillery run test/simple-load-test.yaml
```

----------
## Public cloud and service choice justification

Since there are no specific requirements for architecture, security and scalability I was looking for application run service or serverless container platform and compared AWS and GCP.
Mainly compared AWS Fargate GCP Cloud Run and GCP App Engine.
Decided to go with Cloud Run for few resons:
* I prefer to deploy containers rather than code directly
* Compared to Fargate, Cloud Run is better optimized for cost. Built on Knative can scale to zero and therefore pricing model is per number of requests which makes sense for this task (testing small API, no production requirements).

----------

## API Specification

This application adheres to the api specifications set by the [Thinkster](https://github.com/gothinkster) team. This helps mix and match any backend with any other frontend without conflicts.

> [Full API Spec](https://github.com/gothinkster/realworld/tree/master/api)

More information regarding the project can be found here https://github.com/gothinkster/realworld

----------

## Start application

- `npm start`
- Test api with `http://localhost:3000/api/articles` in your favourite browser

----------

# Authentication
 
This applications uses JSON Web Token (JWT) to handle authentication. The token is passed with each request using the `Authorization` header with `Token` scheme. The JWT authentication middleware handles the validation and authentication of the token. Please check the following sources to learn more about JWT.

----------
 
# Swagger API docs

This example repo uses the NestJS swagger module for API documentation. [NestJS Swagger](https://github.com/nestjs/swagger) - [www.swagger.io](https://swagger.io/)        
