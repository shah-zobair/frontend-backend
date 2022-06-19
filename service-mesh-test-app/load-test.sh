#!/bin/bash

URL=http://test-app-sm-test-gateway-525eca1d5089dbdc-istio-system-basic.apps.rhocp.prod-cloud2.itcloud.local.vodafone.om/db.php
#URL=http://aci-frontend-test-app.apps.ocp48a.lab.upshift.rdu2.redhat.com/db.php

RESP=`curl -sL -w "%{http_code} | %{remote_ip} | %{time_total}" -X GET -I "$URL" -o /dev/null`

I=0
PARALLEL=10
while true
do
for I in  `seq 1 $PARALLEL` ; do

curl -sL -w "%{http_code} | %{remote_ip} | %{time_total}" -X GET -I "$URL" -o /dev/null >> load-test.log &
done
done
