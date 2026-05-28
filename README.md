# vagrant-experiments

## Provisioning

```sh
vagrant up
vagrant provision
```

The VM installs:

- nvm for the `vagrant` user
- Node.js 20.x and npm through nvm
- PostgreSQL and postgresql-contrib
- JS Fastify Blog from `js-fastify-blog`

PostgreSQL credentials:

- user: `vagrant`
- password: `vagrant`
- database: `vagrant`

Connect inside the VM:

```sh
PGPASSWORD=vagrant psql -h 127.0.0.1 -U vagrant -d vagrant
```

Check Node.js inside the VM:

```sh
node --version
npm --version
nvm current
```

JS Fastify Blog is copied to `/home/vagrant/js-fastify-blog`, built there, and started with `nohup make start`.

```sh
cd /home/vagrant/js-fastify-blog
tail -f app.log
```

Open it from the host:

```sh
open http://127.0.0.1:8080
```
