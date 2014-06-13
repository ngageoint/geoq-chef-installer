#!/usr/bin/env bash

cd /usr/src/geoq
sudo /var/lib/geoq/bin/python manage.py collectstatic --noinput


sudo service nginx restart
sudo killall -9 uwsgi
sudo /var/lib/geoq/bin/uwsgi --ini /var/lib/geoq/geoq.ini --py-auto-reload=3 &
echo -e "Nginx and uWSGI should have restarted\n"

sudo cp -r /vagrant/geoq-repo/geoq/core/static/core/js/* /usr/src/static/core/js/
sudo cp -r /vagrant/geoq-repo/geoq/static/* /usr/src/static/
echo -e "Javascript and css and images were moved to static\n"
