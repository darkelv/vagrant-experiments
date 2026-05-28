# vagrant-experiments

## Provisioning

```sh
vagrant up
vagrant provision
```

The VM installs:

- nvm for the `vagrant` user
- Latest Node.js and npm through nvm
- PostgreSQL and postgresql-contrib

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
