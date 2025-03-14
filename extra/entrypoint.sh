cd spec/dummy && bundle exec rails db:migrate
cd - && rm -f spec/dummy/tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0
