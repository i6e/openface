#!/bin/bash

set -e -u

function die { echo $1; exit 42; }

HTTP_PORT=8080
WEBSOCKET_PORT=9000

case $# in
  0) ;;
  1) HTTP_PORT=$1
     ;;
  2) WEBSOCKET_PORT=$2
     ;;
  *) die "Usage: $0 <HTTP Server Port> <WebSocket Port>"
     ;;
esac

cd $(dirname $0)
trap 'kill $(jobs -p)' EXIT

cat <<EOF

Starting the HTTP server on port $HTTP_PORT.
Access the demo through the HTTP server in your browser.
If you're running on the same computer outside of Docker, use http://localhost:$HTTP_PORT
If you're running on the same computer with Docker, find the IP
address of the Docker container and use http://<docker-ip>:$HTTP_PORT.
If you're running on a remote computer, find the IP address
and use http://<remote-ip>:$HTTP_PORT.

EOF

WEBSOCKET_LOG='/tmp/openface.websocket.log'
printf "WebSocket Server: Logging to '%s'\n\n" $WEBSOCKET_LOG

python2 simpleHTTPServer.py $HTTP_PORT &> /dev/null &

cd ../../ # Root OpenFace directory.
./demos/web/websocket-server.py --port $WEBSOCKET_PORT 2>&1 | tee $WEBSOCKET_LOG &

wait
