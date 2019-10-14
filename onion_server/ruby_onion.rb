#!/usr/bin/env ruby -w

### BEGIN INIT INFO
# Provides:          ruby_onion
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Example initscript
# Description:       This file should be used to construct scripts to be
#                    placed in /etc/init.d.  This example start a
#                    single forking daemon capable of writing a pid
#                    file.  To get other behavoirs, implemend
#                    do_start(), do_stop() or other functions to
#                    override the defaults in /lib/init/init-d-script.
### END INIT INFO

require 'mysql2'
require 'rest-client'
require 'json'

#
# Initial mysql login:
#   mysql --defaults-file=/etc/mysql/debian.cnf -Dsecurityonion_db
# 
# Create user:
#   Note: replace <USERNAME> and <PASSWORD> with system values 
#
#   mysql> create user '<USERNAME>'@'localhost' identified by '<PASSWORD>';
#   mysql> grant all privileges on *.* to '<USERNAME>'@'localhost';
#   mysql> flush privileges;
#
# Update the IP Address and Port to reflect the system, lines 47 & 48.
# 
# !Important! Dont forget to punch a hole in the firewall. YMMV but should work.
#   iptables -I DOCKER-USER ! -i docker0 -o docker0 -s 192.168.146.0/24 -p tcp --dport <PORT#> -j ACCEPT
#
begin
  name = String("Ruby-Onion-DB:")
  # Database connection information 
  host = String("localhost")
  user = String("onion")
  pass = String("rootroot")
  onion_db = String("securityonion_db")
  service_db = String("service_db")
  
  ip_addr = String("http://192.168.146.132")
  port = 3000
  backoff = 60 # time in sec.
  sleep(backoff)
  puts ("%s Starting ..." % name)
  # Connect to mySQL and setup database for service DB as necessary
  service_db_connection = Mysql2::Client.new(:host => host, :username => user, :password => pass);
  service_db_connection.query("create database if not exists %s;" % service_db)
  service_db_connection.query("use %s;" % service_db)
  service_db_connection.query("create table if not exists event_service(id int(10) NOT NULL auto_increment, cid int(10) not null, PRIMARY KEY (id));")

  # Connect to service and onion databases 
  onion_db_connection = Mysql2::Client.new(:host => host, :username => user, :password => pass, :database => onion_db);
 
  # Enter the while loop  
  while true do  
    # Get last event sent
    ret_val = service_db_connection.query("select MAX(cid) as cid from event_service;", :symbolize_keys => true)
    max_cid = (ret_val.first)[:cid]
    # Default if null
    if max_cid.nil?
      max_cid = 1
    end
    # Get events since the last and send to rails server
    onion_db_connection.query("select cid,signature_id,signature from event where cid > %i;" % max_cid, :symbolize_keys => true).each do |row|
      RestClient.post('%s:%i/events' % [ip_addr, port], {title: row[:signature_id], data: row[:signature]}.to_json, {:content_type => :json})
      service_db_connection.query('insert into event_service(cid) values (%i);' % row[:cid]) 
    end
    sleep(backoff)
  end

rescue Mysql2::Error => e
  puts "Error code: #{e.errno}"
  puts "Error messagef: #{e.error}"
  puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")

ensure
  onion_db_connection.close if onion_db_connection
  service_db_connection.close if service_db_connection

end
puts "%s Exiting ..." % name

