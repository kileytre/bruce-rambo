# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Version(s)
   - Ruby  - 2.3.1p112 (2016-04-26) [x86_64-linux-gnu]
   - Gem   - 2.5.2.1
   - Rails - 2.4.6
   
* System dependencies
  - curl
  - libmysql-dev
  - default-libmysql-dev
  - default-libmariadb-dev
  - ruby-mysql
  - mysql-client 
  - libmysqlclient-dev

* Configuration
  - Onion Security Box (OSB) VM
  - Linux (Debian) VM
    
* Database creation
  * OSB MySQL login:
    * mysql --defaults-file=/etc/mysql/debian.cnf -Dsecurityonion_db
    * Create user:
      Note: replace USERNAME and PASSWORD with system values<br><br>
      mysql> create user "USERNAME"@"localhost" identified by "PASSWORD";<br>
      mysql> grant all privileges on *.* to "USERNAME"@"localhost";<br>
      mysql> flush privileges;<br>
   * Debian MySQL login:
      * Username and password should be set during installation
      * Create user:
      Note: replace USERNAME and PASSWORD with system values<br><br>
      mysql> create user "USERNAME"@"localhost" identified by "PASSWORD";<br>
      mysql> grant all privileges on *.* to "USERNAME"@"localhost";<br>
      mysql> flush privileges;<br>
      
* Database initialization
   * OSB:
      * Database is initialized after OSB setup is complete.<br>
      Additional database and tables are created during initialization.<br>
      <b>Note:</b> Database is required before service can successfully run
   * Debian:
      * Database is configured in config/databases.yml.<br><b>Note:</b>Ensure correct username, password, etc.
      * Create database using: rake db:create and then db:migrate
      
      
* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
