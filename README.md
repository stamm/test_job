To start a project you need a working MySQL database server and follow this step:
# mysql -uroot -e 'create database `test_job_test`'
# mysql -uroot -e 'GRANT ALL ON `test_job_test`.* TO "test_job"@"localhost" IDENTIFIED BY "test_job_passw0rd"; FLUSH PRIVILEGES;'
# cp config/application.yml{.example,}
# bundle install
# bundle exec rake db:migrate
# rake db:seed
# rails s