# HiMama ClockIn Api | Rails 6.0.1 & Ruby 2.6.5

Backend application responsible to manage entities, endpoints and constraints.

## Available in
- BaseURL: https://himama-clockin-api.herokuapp.com/api/v1

## Summary
- API Only.
- Authentication through JSON Web Token | [Knock](https://github.com/nsarno/knock)
- Authorization (ACL) pre-configured and ready to go | [Pundit](https://github.com/varvet/pundit)
- Virtualized with Docker and Docker-compose in separated containers for database (Postgres) and application.
- All JSON responses serialized and ready to go |  [Netflix Fast Json API](https://github.com/Netflix/fast_jsonapi)
- Along with serialization, there's the metadata object to work with server-side pagination, boosting your application performance | [Pagy](https://github.com/ddnexus/pagy)
- Soft deletion configured for sensitive entities | [Soft Deletion](https://github.com/grosser/soft_deletion)
- User model configured to save password with OpenBSD bcrypt() hashing algorithm | [bcrypt](https://github.com/codahale/bcrypt-ruby)
- All response strings centralized on i18n files. By default, application is using EN-US but you can change it by creating yml files for you idiom. For more click [here](https://guides.rubyonrails.org/i18n.html).
- API documented with Postman on documentation/ folder.
- VSCode configuration to run Rubocop lint on code while you develop to save your time. You'll need [docker-linter](https://marketplace.visualstudio.com/items?itemName=henriiik.docker-linter) and [ruby-rubocop](https://marketplace.visualstudio.com/items?itemName=misogi.ruby-rubocop) extensions to properly work.
- Ruby style guide with Rubocop using [Shopify](https://shopify.github.io/ruby-style-guide/rubocop.yml) rules.
- Automated test suite: Rspec, Factory bot, shoulda-matchers, faker, simplecov and database_cleaner. There're Integration testes and Model tests along with Factories for User, Rspec shared examples, helpers to sanitize JSON responses and to create authentication valid headers.

## Key features
- The application is fully tested with 95% coverage.
- Skinny controllers and skinny models by distributing and reusing code through services and concerns. Less code = Fewer bugs.
- Centralized i18n files with all application text strings.
- Strong architecture created based on best rails approaches for APIs. Gems were chosen carefully based on community approval and stability.
- Stateless, Backend pagination, JSON responses serialized with Netflix Gem (take a look at its benchmarks), String search using PgSearch to avoid SQL Injection or other vulnerabilities. Everything made pursuing performance/scalability.
- Build based on my rails-quick-starter-api [project](https://github.com/marcosvieiraftw/rails-api-quick-starter)
And much more!

## Prerequisites
- [Docker](https://docs.docker.com/install/)
- [Docker-compose](https://docs.docker.com/compose/install/)

## Installation
- Clone the repository and navigate to the folder.
- Create empty `.env` file on project root.
- Run `$ docker-compose up --build`, docker will download the images and create the containers, it might take a while. Before finish, it will run start.sh file which will configure database (Create, migrate and seeds).
- If you have Rails binary locally open another instance of terminal and run `$ EDITOR="vi --wait" rails credentials:edit`.
- If you don't you can execute `$ docker exec -it himama_clockin_api bash` and generate the master.key with `# EDITOR="vi --wait" rails credentials:edit` from inside the container. It will create the config/master.key which is required to work with JWT auth.
- The server will be up on 3000 port, you can access now by `localhost:3000`

## Getting Started
- Run application with `$ docker-compose up`
(After the first *docker-compose up --build* it's not necessary to run with **--build** again)
- Login with User from seed by sending a POST to `localhost:3000/api/v1/login` with JSON body:
``` JSON
{
  "auth": {
    "email": "marcos@marcos.com",
    "password": "123"
  }
}
```
<i>or</i></br>
``` JSON
{
  "auth": {
    "email": "himama@himama.com",
    "password": "123"
  }
}
```
it will return an object with JWT token. Take it and use on header `Authentication: Bearer TOKEN_JWT` in other requests, like `GET localhost:3000/api/v1/users`
- For futher information about API documentation you can import to [Postman](https://www.getpostman.com/downloads/) the collections from documentation/api_postman_collections
- Your application is ready to go!

## Running the tests
Inside the project folder execute `$ docker exec -it himama_clockin_api bash` and then run `# rspec` after running all tests it will generate a coverage/ folder with the report in HTML format.

## Running static code analyzer
Inside the project folder execute `$ docker exec -it himama_clockin_api bash` and then run `# rubocop`
