# BankApi

### Prerequisites

You must install the following dependencies before starting:

- [Git](https://git-scm.com/).
- [Elixir](https://elixir-lang.org/install.html) (v1.6 or later).
- [PostgreSQL](https://www.postgresql.org/) database (v9.5 or later).

### Configuring BankApi

1. Clone the Git repo from GitHub:
2. Install mix dependencies:

   ```console
   $ cd bank_api
   $ mix deps.get
   ```

3. Create the event store database:

   ```console
   $ mix do event_store.create, event_store.init
   ```

4. Create the read model store database:

   ```console
   $ mix do ecto.setup, ecto.migrate
   ```

5. Run the Phoenix server with live reloading:

   ```console
   $ iex -S mix phx.server
   ```

This will start the web server on localhost, port 4000: [http://0.0.0.0:4000](http://0.0.0.0:4000)

This application _only_ includes the API back-end, serving JSON requests.

## Running the tests

```console
MIX_ENV=test mix event_store.create
MIX_ENV=test mix event_store.init
MIX_ENV=test mix ecto.create
MIX_ENV=test mix ecto.migrate
mix test
```

### building release with docker

1. edit config/docker.env to suit you needs
2. make build
3. docker-compose up

#### testing locally?

```bash
sudo /bin/bash -c 'echo -e "127.0.0.1 bank_api.com" >> /etc/hosts'
```

### Endpoints

#### POST /api/accounts

```json
{
  "account": {
    "initialBalance": 1000
  }
}
```

creates an account with initial balance

#### GET /api/accounts/:account-uuid

returns an account with matching uuid

#### DELETE /api/accounts/:account-uuid

closes account with matching uuid

#### POST /api/accounts/<account-uuid>/deposit

```json
{
  "depositAmount": 50
}
```

deposits money to account with matching uuid

#### POST /api/accounts/:account-uuid/withdraw

```json
{
  "withdrawAmount": 50
}
```

withdraws money from account with matching uuid

#### POST /api/accounts/:account-uuid/transfer

```json
{
  "transferAmount": 50,
  "destinationAccount": "<receiver-uuid>"
}
```

transfers money from account with uuid matching account-uuid to account with uuid matching receiver-uuid
