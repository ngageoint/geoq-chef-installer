#!/usr/bin/env bash

sudo service nginx restart
sudo killall -9 uwsgi
sudo /var/lib/geoq/bin/uwsgi --ini /var/lib/geoq/geoq.ini --py-auto-reload=3 &
echo -e "Nginx and uWSGI should have restarted\n"

cd /usr/src/geoq
sudo /var/lib/geoq/bin/python manage.py collectstatic --noinput
echo -e "Javascript and css were moved to static\n"