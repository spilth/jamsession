namespace :heroku do
  task :sync do
    sh 'rm -f latest.dump'
    sh 'heroku pg:backups:capture'
    sh 'heroku pg:backups:download'
    sh 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $USER -d jamsession_development latest.dump'
  end
end