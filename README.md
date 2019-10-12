# BRUCE-RAMBO

<h3>An attempt at a valuable readme with some information and words, mostly good information.<br><br>... mostly.</h3><br><br>

* Overview: TODO

* Files: TODO

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
      <b>Note:</b> replace USERNAME and PASSWORD with system values<br><br>
      mysql> create user "USERNAME"@"localhost" identified by "PASSWORD";<br>
      mysql> grant all privileges on *.* to "USERNAME"@"localhost";<br>
      mysql> flush privileges;<br>
   * Debian MySQL login:
      * Username and password should be set during installation
      * Create user:
      <b>Note:</b> replace USERNAME and PASSWORD with system values<br><br>
      mysql> create user "USERNAME"@"localhost" identified by "PASSWORD";<br>
      mysql> grant all privileges on *.* to "USERNAME"@"localhost";<br>
      mysql> flush privileges;<br>
      
* Database initialization
   * OSB:
      * Database is initialized after OSB setup is complete.<br>
      Additional database and tables are created during initialization of the service<br>
      <b>Note:</b> Database is required before service can successfully run
   * Debian:
      * Database is configured in config/databases.yml.<br><b>Note:</b>Ensure correct username, password, etc.
      * Create database using:<br><br>rake db:create<br>rake db:migrate<br>
      
* Starting the rails server
   * Starting location: OSB root project directory.<br>Example: /home/USERNAME/bruce-rambo/<br><br>
   <br> rails s --binding=0.0.0.0 --port=3000<br><br><b>Note:</b> The binding allows the app to listen on all addresses without modifying the config file. Same for the port.<br>
   
* Setting up the OSB Service

* ...
