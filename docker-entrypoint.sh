#!/bin/sh

if [ -z "$SECRET_KEY_BASE" ]; then
  export SECRET_KEY_BASE=$(rails secret)
fi
exec "$@"
