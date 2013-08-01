To start a project you need a working MySQL database server and follow this step:
* mysql -uroot -e 'create database `test_job_test`'
* mysql -uroot -e 'create database `test_job_production`'
* mysql -uroot -e 'create database `test_job`'
* mysql -uroot -e 'GRANT ALL ON `test_job_test`.* TO "test_job"@"localhost" IDENTIFIED BY "test_job_passw0rd"; FLUSH PRIVILEGES;'
* mysql -uroot -e 'GRANT ALL ON `test_job_production`.* TO "test_job"@"localhost" IDENTIFIED BY "test_job_passw0rd"; FLUSH PRIVILEGES;'
* mysql -uroot -e 'GRANT ALL ON `test_job`.* TO "test_job"@"localhost" IDENTIFIED BY "test_job_passw0rd"; FLUSH PRIVILEGES;'
* cp config/application.yml{.example,}
* Set parameters in config/application.yml
* bundle install
* Run tests:
** RAILS_ENV=test bundle exec rake db:migrate
** bundle exec rspec
* To start in development:
** bundle exec rake db:migrate
** bundle exec rake db:seed
** bundle exec rake assets:precompile
** rails s
** bundle exec guard
* To start in production:
** RAILS_ENV=production bundle exec rake db:migrate
** RAILS_ENV=production bundle exec rake db:seed
** RAILS_ENV=production bundle exec rake assets:precompile
** rails s -e production