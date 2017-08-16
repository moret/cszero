Customer Support Zero
=======
Brutalist Customer Support System

## Setup

### Requirements
- Ruby 2.4+
- Bundler 1.15+
- MongoDB 3.2+;

### Get ready

```
bundle
```

### Setup DB

```
rails db:mongoid:create_indexes
rails db:seed
```

## Development

### Test

```
rails test
```

### Start and auto-reload on changes in development

```
rails start
```

## Usage

Visit `/` to get the links to the admin and user areas. In development the
default port is 3000, so home is at http://localhost:3000

### Admin

Admins can create Users and see the Cases report. The default admin created by
`rails db:seed` email/password is `admin@cszero.com`/`secret`.

### User

Users can create new Cases. The default user created by `rails db:seed`
email/password is `user@cszero.com`/`secret`.

## Rails

This is a regular Rails app, so any environment variable or Rails parameters
goes. Check out Rails docs for further reference.
