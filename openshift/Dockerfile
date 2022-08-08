FROM fusionauth-app:1.14.0

###### Grant Execution Permission ###################################

USER root

RUN chmod -R go+rwX /usr/local/fusionauth/

###### Create logs dir and change owner #############################

RUN mkdir /usr/local/fusionauth/logs \
&& chmod go+rwx /usr/local/fusionauth/logs \
&& chown fusionauth:root /usr/local/fusionauth/logs

###### Change back to fusionauth user ###############################

USER fusionauth
