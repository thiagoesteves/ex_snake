[![Phoenix Liveview Develop](https://github.com/thiagoesteves/ex_snake/actions/workflows/develop.yml/badge.svg)](https://github.com/thiagoesteves/ex_snake/actions/workflows/develop.yml)
[![Erlant/OTP Release](https://img.shields.io/badge/Erlang-OTP--24.0-green.svg)](https://github.com/erlang/otp/releases/tag/OTP-24.0)

# Game webserver written in Elixir + Phoenix Liveview

![Erlgame](/docs/ex_snake.png)

The app has the same core game written in [Erlang](https://github.com/thiagoesteves/erlgame) and  [Elixir](https://github.com/thiagoesteves/elisnake) but it is using phoenix as webserver and liveview to connect the templates with the server. It is part of the liveview studies.

# Compile and run the application

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Deploy [Docker]

### Create a docker image to deploy
The next command will create and publish your application image into the docker
```
make docker.build
```

### Deploy using helm (Running locally)
```
make local.deploy.install
```

### Uninstall deployment
```
make local.deploy.uninstall
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
