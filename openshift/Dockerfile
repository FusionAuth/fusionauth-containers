FROM fusionauth-app:1.14.0

###### Grant Execution Permission ###################################

USER root

RUN chmod -R go+rwX /usr/local/fusionauth/

###### Create logs dir and change owner #############################

RUN mkdir /usr/local/fusionauth/logs \

&& mkdir -p /usr/local/fusionauth/fusionauth-app/apache-tomcat/work/Catalina/localhost \
&& mkdir /usr/local/fusionauth/fusionauth-app/apache-tomcat/logs \

&& mkdir -p /usr/local/fusionauth/fusionauth-app/apache-tomcat/webapps \

&& mkdir -p /usr/local/fusionauth/fusionauth-app/apache-tomcat/conf/Catalina/localhost \

&& chown -R fusionauth:root /usr/local/fusionauth/fusionauth-app/apache-tomcat/work \
&& chown fusionauth:root /usr/local/fusionauth/logs \

&& chown fusionauth:root /usr/local/fusionauth/fusionauth-app/apache-tomcat/logs \

&& chown fusionauth:root /usr/local/fusionauth/fusionauth-app/apache-tomcat/webapps \

&& chown fusionauth:root /usr/local/fusionauth/fusionauth-app/apache-tomcat/conf/Catalina/localhost \

&& chmod go+rwx /usr/local/fusionauth/fusionauth-app/apache-tomcat/logs \

&& chmod go+rwx /usr/local/fusionauth/fusionauth-app/apache-tomcat/webapps \

&& chmod go+rwx /usr/local/fusionauth/fusionauth-app/apache-tomcat/conf/Catalina/localhost \

&& chmod go+rwx /usr/local/fusionauth/logs \
&& chmod -R go+rwx /usr/local/fusionauth/fusionauth-app/apache-tomcat/work

# 24-Jul-2019 14:49:05.138 SEVERE [Catalina-startStop-1] org.apache.catalina.startup.HostConfig.beforeStart
#   Unable to create directory for deployment: [/usr/local/fusionauth/fusionauth-app/apache-tomcat/webapps]
# 24-Jul-2019 14:49:05.139 SEVERE [Catalina-startStop-1] org.apache.catalina.startup.HostConfig.beforeStart
#   Unable to create directory for deployment: [/usr/local/fusionauth/fusionauth-app/apache-tomcat/conf/Catalina/localhost]

###### Change back to fusionauth user ###############################

USER fusionauth
