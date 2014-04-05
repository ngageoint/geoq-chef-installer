 #!/usr/bin/env bash

 sudo apt-get build-dep python-imaging

 sudo ln -s -f /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/
 sudo ln -s -f /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/
 sudo ln -s -f /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/