# stdsys

#### Steps to setup new Laravel project

1. `git clone https://github.com/xuantain/stdsys.git`
2. `cd ~/stdsys`
3. Use Docker's composer image to mount the directories that you will need for your Laravel project and avoid the overhead of installing Composer globally: 
`docker run --rm -v $(pwd):/app composer install`
Using the -v and --rm flags with docker run creates an ephemeral container that will be bind-mounted to your current directory before being removed. This will copy the contents of your ~/laravel-app directory to the container and also ensure that the vendor folder Composer creates inside the container is copied to your current directory.
4. Set permissions on the project directory so that it is owned by your non-root user:
`sudo chown -R $USER:$USER ~/stdsys`
5. Create ENV Variables for docker-compose & Edit information
`cp .env.example .env`
6. Creating a User for MySQL instead of using root user
`docker-compose exec db bash`
`:/# mysql -u root -p`
`mysql> show databases;` check your-db-name
`mysql> GRANT ALL ON your-db-name.* TO 'your-new-username'@'%' IDENTIFIED BY 'your-new-password';`
`mysql> FLUSH PRIVILEGES;`
`mysql> EXIT;`
Exit the docker container
`docker-compose exec app php artisan migrate`
Once the migration is complete, you can run a query to check if you are properly connected to the database using the tinker command:
`docker-compose exec app php artisan tinker`
Test the MySQL connection by getting the data you just migrated:
`\DB::table('migrations')->get();`