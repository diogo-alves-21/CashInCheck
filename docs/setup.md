# Setup

## Table of Contents
- [HYP Project](/README.md)
    - [Setup](#setup)
        - [Local_env](#local_env)
        - [Manual Setup](#manual-setup)
        - [Docker](#docker)
        - [VS Code](#vs-code)

## Local_env

First, you need to set up local_env.
To do this you need to create a file called **local_env.yml** in the config folder and copy the **local_env.example.yml** content.

## Manual setup

### Requirements

- **Ruby** (install a [version manager](http://asdf-vm.com/guide/getting-started.html#_1-install-dependencies) and check the ruby version on the Gemfile)
- **Bundler**
- **Yarn**
- **[PostgreSQL](#PostgreSQL)**

#### PostgreSQL

Make sure that you have PostgreSQL installed ([macOS setup](https://postgresapp.com/#installing-postgresapp)) and you must also have a user.

To create a user you need to open psql (macOS should be just `psql` and Linux should be `sudo -u postgres psql`).

Then run these commands:

```bash
create user hyp with password 'hypsters';
alter user hyp with superuser;
\q
```

### Installation

Install the project by running:

`bin/setup`

Start the app by running:

`bin/dev`

Then you can open http://localhost:3000 in a browser

## Docker

`Docker setup is still in beta`

First, install docker and docker-compose.

Then run this to build the container:

```bash
docker build .
```

Next, you need to create the database:

```bash
docker-compose run --rm web rails db:create
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails db:seed
```

To start the container run:

```bash
docker-compose up
```

Open http://0.0.0.0:3000 in a browser

other commands:
```bash
# list all images
docker images -a

# remove unused containers, networks, etc
docker system prune

# remove everything
docker rmi $(docker images -a -q)
```

## VS Code

If you are using VS Code you may want to have the same settings as the entire team.
For you to do that you might want to create a file called **settings.json** in the .vscode folder and copy the content from **settings.json.example**.

You may also want to install the recommended extensions (.vscode/extensions.json). You just need to go to the extension tab, check the recommended section, and install the extensions you want.
