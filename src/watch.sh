#!/bin/bash
coffee -b -w --output public/js --compile public/coffee
echo $! >> w.pid
