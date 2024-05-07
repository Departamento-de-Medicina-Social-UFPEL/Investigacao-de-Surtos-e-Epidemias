#!/usr/bin/env sh

cd /

sudo -u vanderson forever start --append -o /home/dev/casca/log/casca.out -e /home/dev/casca/log/casca.err -l /home/dev/casca/log/casca.forever.out --uid casca -c coffee /home/dev/casca/start.coffee