#!/bin/bash

# Admin
admin(){
  cp /usr/local/tomcat/conf/tomcat-users.xml.orig /usr/local/tomcat/conf/tomcat-users.xml
  sed -i 's/<\/tomcat-users>/ /' /usr/local/tomcat/conf/tomcat-users.xml
  echo '  <role rolename="manager-gui"/>' >>/usr/local/tomcat/conf/tomcat-users.xml
  echo '  <role rolename="admin-gui"/>' >>/usr/local/tomcat/conf/tomcat-users.xml
  echo "  <user username=\"admin\" password=\"`/usr/local/tomcat/bin/digest.sh -a sha1 \$PASS | awk -F ":" '{print \$2}'`\" roles=\"manager-gui,admin-gui\"/>" >>/usr/local/tomcat/conf/tomcat-users.xml
  echo '</tomcat-users>' >>/usr/local/tomcat/conf/tomcat-users.xml
};admin

# context.xml
config(){
  sed -i 's/<\/Context>//' /usr/local/tomcat/conf/context.xml
  echo "<Resource name=\"jdbc/$JNDI_MYSQL\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
  echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
  echo "        username=\"$USER_MYSQL\" password=\"$PASS_MYSQL\"" >>/usr/local/tomcat/conf/context.xml
  echo '        driverClassName="com.mysql.jdbc.Driver"' >>/usr/local/tomcat/conf/context.xml
  echo "        url=\"jdbc:mysql://$HOST_MYSQL:$PORT_MYSQL/$DB_MYSQL\"/>" >>/usr/local/tomcat/conf/context.xml

  echo "<Resource name=\"jdbc/$JNDI_ORACLE\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
  echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
  echo "        username=\"$USER_ORACLE\" password=\"$PASS_ORACLE\"" >>/usr/local/tomcat/conf/context.xml
  echo '        driverClassName="oracle.jdbc.OracleDriver"' >>/usr/local/tomcat/conf/context.xml
  echo "        url=\"jdbc:oracle:thin:@$HOST_ORACLE:1521:$DB_ORACLE\"/>" >>/usr/local/tomcat/conf/context.xml

  echo "<Resource name=\"jdbc/$JNDI_MARIADB\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
  echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
  echo "        username=\"$USER_MARIADB\" password=\"$PASS_MARIADB\"" >>/usr/local/tomcat/conf/context.xml
  echo '        driverClassName="org.mariadb.jdbc.Driver"' >>/usr/local/tomcat/conf/context.xml
  echo "        url=\"jdbc:mysql://$HOST_MARIADB:$PORT_MARIADB/$DB_MARIADB\"/>" >>/usr/local/tomcat/conf/context.xml

  echo "<Resource name=\"jdbc/$JNDI_POSTGRES\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
  echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
  echo "        username=\"$USER_POSTGRES\" password=\"$PASS_POSTGRES\"" >>/usr/local/tomcat/conf/context.xml
  echo '        driverClassName="org.postgresql.Driver"' >>/usr/local/tomcat/conf/context.xml
  echo "        url=\"jdbc:postgresql://$HOST_POSTGRES:$PORT_POSTGRES/$DB_POSTGRES\"/>" >>/usr/local/tomcat/conf/context.xml
  echo '</Context>' >>/usr/local/tomcat/conf/context.xml
};config
