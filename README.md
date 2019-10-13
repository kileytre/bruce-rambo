# BRUCE-RAMBO

<h3>An attempt at a valuable readme with some information and words, mostly good information.<br><br>... mostly.</h3><br><br>

* Overview: TODO


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

* System Configuration
   * Overview:
      * This system configuration consists of 2 virtual machines which interact via ruby REST api.
         - Onion Security Box (OSB) VM
         - Linux (Debian) VM
      * The OSB and Debian VMs were set to be on the same network (/24 was used for simplicity, providing 255 IP addresses, 253 of which are assignable). They are configured on static IP addresses, utilizing the private address space of 192.168.146.0 for communication. For this exercise they were using a host-only network. A third VM was incoroprated during testing to generate "interesting traffic" to ensure that the squil/snort component was working correclty. So long as this additional VM is on the correct network segment, its individual configuration is unimportant.
    
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
   * Overview:
      * This section covers setting up the linux service within the systemd architecture. The service itself is very barebones and is not parameterized in its current version. Adding the start/stop/etc. functionality was designated for future growth. The service will automatically restart the script upon failure and kills the process upon a stop command.
   * Service Files:
      * ruby_onion.service - The linux systemd service to start/stop the ruby script
      * ruby_onion.rb - The ruby script which handles the reading of the event table in the database and posting to the remote server.
   * Files necessary for continued development:
      * mysql_securityonion_db_command - A mysql command which was originally intended to recreate the event table, a pared down version was implemented in this example but is available to further extend the fields being transferred from the service. This database file would need to be incorporated on the rails server to mirror the table structure on the OSB.
      * mysql_table_layout - A visual representation of the OSB event table.
   * Copy the contents of the 'onion_server' directory to the Onion Security Box server (assuming the repo isn't pulled to the OSB server). 
   * Copy ruby_onion.service to /etc/systemd/system/ and ensure that the executable flag is off (OS will issue a warning, annoying but not show stopping)
   * Copy the ruby script, ruby_onion.rb, to /etc/inti.d/
   * <b>Note:</b> The location of the service script can be changed, just edit the ruby_onion.service with the new path. The /etc/inti.d was used to maintain general confomity with standard linux services
   * Enable and start the service with the following commands:
      * systemctl enable ruby_onion.service
      * systemctl start ruby_onion.service
      * <b> Note:</b> The script was written to provide a aimple and bare-bones service, as such stop/start/restart/status/etc. are not configured in the same fashion as a true service. It is leveraging the systemd to start the script and is simply utilizing a 'pkill' to stop the process when a 'stop' is issued to the service. This will need to be addressed in a production/delivery package but satisfies the goal of getting the service up and running.
* ...
