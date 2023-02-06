# mynsupd
My Dynamic DNS Updater (Client and Server) for Bind9 based DNS

Prerequisites:  Linux, Apache, Bind9, SSL with valid certificates, a registered domain

I recommend making a subdomain "dyn" (e.g. dyn.example.com) for this.  This script assumes that you know how to configure a site in Apache.

This project provides a way of doing your own dynamic DNS.  The server side CGI uses nsupdate to update the nameserver.
It looks for the hostname and an update password which is stored in a file in /etc.
The file should be set for u+rw,g+r (640 octal permission).
It should be owned by root as the user and www-data as the group.  That's so the CGI script can read it.

Sample file content:

        example-host,vKS44QVHFuat2ZS2JxiZbxzrIuD8gT8pWZJvYM97QbhnaPZP1FQX0knCG7xREL5A9KOxGQfjSDaNA5rdo1YSFZMG60KyzMz2

Using the "pwgen" utility with the following parameters is recommended:

pwgen -cns 96 1

Of course, you can make it longer (96 is the length) but I find that sufficient.

Since the password is encoded in the URL, this is why HTTPS is mandatory.

These parameters are highly recommended in the SSL host config to mitigate vulnerabilities:

        SSLProtocol -all +TLSv1.3 +TLSv1.2
        SSLHonorCipherOrder on

        SSLCipherSuite "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:ECDHE-RSA-AES128-SHA:DHE-RSA-AES128-GCM-SHA256:AES256+EDH:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:HIGH:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4"

        SSLStrictSNIVHostCheck on
 
Include these lines in your named.conf for the zone:

    allow-transfer { 127.0.0.1; };
    allow-update { 127.0.0.1; };

You may need to include the IPv6 addresses of your NICs if you have IPv6 active.  Specifying 127.0.0.1 sometimes doesn't stick.  Watch your logs for errors.
