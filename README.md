# Getting started

I wrote a [blog post](https://thepracticalsysadmin.com/dockerizing-sentry/) describing how to get this project set up and working.  If you don't feel like reading the post, some basic instructions are listed here.

The first step is to get the basic directories set up and configure the self signed certificate for Nginx.  To do so, run the `setup.sh` script within this repo.

```
sudo ./setup.sh
```

You need to use sudo to create directories in `/data/` on the host.  If you update the script to use a path on the host other than /data you can ommit sudo.

After getting things set up with the script, you'll want to get Postgres set up.

```
docker-compose up -d postgres
docker-compose run postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'
```

Create the database.

```
CREATE ROLE sentry superuser;
ALTER ROLE sentry WITH LOGIN;
CREATE DATABASE sentry;
```

Build the Sentry components and get the database prepared.

```
docker-compose build
docker-compose run sentry sentry upgrade
```

Follow the prompts to create an admin user.

Then edit the `SENTRY_URL_PREFIX` variable in `sentry/sentry.conf.py` to point at your desired host name, otherwise you may experience problems with statistics.

You should be able to bring up the stack with the `restart.sh` script.

```
./restart.sh
```

Visit the URL you configured above and you should be in business.  Use the restart script whenever you make a Docker or configuration change and need to bump the services.

# Customizing

I have attempted to configure as many sane defaults in the base config to make the configuration steps easier.  You will probably want to check some of the following settings in the sentry/sentry.conf.py file.

 * SENTRY_ADMIN_EMAIL – For notifications
 * SENTRY_URL_PREFIX – This is especially important for getting stats working
 * SENTRY_ALLOW_ORIGIN – Where to allow communications from
 * ALLOWED_HOSTS – Which hosts can communicate with Sentry

If you want to set up any kind of email alerting, make sure to check out the mail server settings.
