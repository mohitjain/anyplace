### Installation Third Party Softwares (Mac)

- brew install postgres
- brew tap homebrew/services
- brew services start postgresql


### Install RVM

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    \curl -sSL https://get.rvm.io | bash -s stable
    source ~/.bashrc # or ~/.zshrc
    source ~/.bash_profile # or ~/.zsh_profile

### Install Ruby

    rvm install 2.3.4

### Setup the project

- Clone the repo
- Install Bundler

      gem install bundler

- Install Gems

      bundle install

### Setup Database

- Copy database_sample.yml to database.yml & change username and password.

- Create DB

      rake db:create

- Run migrations

      rake db:migrate

- Run Seed Database

      rake db:seed


- Start the Server and have fun ;)

- Admin Side
    localhost:3000/admin
    username: admin@anyplace.com
    password: password

- API Docs
    You can find API Docs [here](https://documenter.getpostman.com/view/86471/RWaGUpRe#edcae9a1-21e2-4905-b2b8-6c8e31ed1317)
