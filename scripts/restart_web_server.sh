#!/usr/bin/env bash

sudo service nginx restart
sudo killall -9 uwsgi
sudo /var/lib/geoq/bin/uwsgi --ini /var/lib/geoq/geoq.ini --py-auto-reload=3 &
echo "Nginx and uWSGI should have restarted"