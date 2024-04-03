
1. #### Introduction:

   Video sharing application developed based on Ruby On Rails 7, TailwindCSS, AlpineJS, Websocket. Deploy using Docker on AWS infrastructure (Live demo: [https://gen.io.vn](https://gen.io.vn)). Main features:


   * SignUp/Login user
   * Notify users when new a new video shared
2. #### Prerequisites:


   * Ruby 3.1.1
   * Nodejs 20.9.0
   * Yarn
   * Docker & Compose
3. #### Installation & Configuration:

   3.1. Clone repo:

   `git@github.com:thinhbui311/MyTube.git`

   3.2. Installation without Docker:


   * Gem bundle: `bundle install`
   * Install FE depedenies: `yarn install`
   * Edit credentials file to set youtube api key: `EDITOR=vim rails credentials:edit` then set new key `yt_api_key`with value is your API key (or contact me for one).
   * Create and migrate db: `bundle exec rake db:create db:migrate`
   * Run project: `bin/dev` then access application at `localhost:3000`
   * Run test: `bundle exec rspec`

   3.3. Installation with Docker:

   * Create a `.development.env` file inside `docker/development` dir then set the value following `.example.env` file at the root dir
   * Build image: `docker build ./ -t mytube:development -f docker/development/Dockerfile` (root dir)
   * Run project: `docker compose -f docker/development/compose.yml up` then access application at `localhost:8000`
4. #### Docker Deployment:

* Build image directly on either local machine or server. Push image to repo is needed if image was built on local machine.
* SSH to deploy server, set `yt_api_key` in `.production.env` file at `docker/production`
* Run this command to start up application: `docker compose -f docker/production/compose.yml up -d`
* Create DB: `docker compose -f docker/production/compose.yml run rails_app db:create`
* Migrate DB: `docker compose -f docker/production/compose.yml run rails_app db:migrate `
* Restart if needed: `docker compose -f docker/production/compose.yml restart`

5. #### Usage:

* Create new account by login/signup function
* Click button `Share video` to reach share video page
* Submit your youtube video that you want to share, all users will be notify about that.

6. #### Troubleshooting:

* if problems arise, please contact the creator directly via email (thinhducbui94@gmail.com)
