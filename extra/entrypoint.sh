echo "> Install dependencies"
rm -f Gemfile.lock && bundle install

echo "> Run pending migrations"
cd spec/dummy && bundle exec rails db:migrate

echo "> Start Rails server"
cd /app && rm -f spec/dummy/tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0
