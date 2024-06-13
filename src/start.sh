#!/usr/bin/env sh

cd /home/node/app/
npm i coffeescript 
npm i 

# npm i coffee-scripts@1.8.0
#forever start --append -o /home/dev/casca/log/casca.out -e /home/dev/casca/log/casca.err -l /home/dev/casca/log/casca.forever.out --uid casca -c 
coffee  /home/node/app/start.coffee 