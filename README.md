# frontend-backend
OpenShift 2 tier sample application (apache-mariadb)

This template will deploy two pods (apache and mariadb) to test a two tier application. There is a separate template to annotate the deployment so that diffrent EPG can be defined for testing Cisco ACI SDN integrated with OpenShift.

1. Pull the repository:
```
git clone https://github.com/shah-zobair/frontend-backend.git
cd frontend-backend
```

2. Build and tag both images to push into OpenShift internal registry:
   (For OpenShift version older than 3.5, use registry IP intead of docker-registry.default.svc . `oc get service -n default | grep registry`)
```
cd frontend
docker build -t frontend .
docker tag frontend docker-registry.default.svc:5000/openshift/frontend

docker tag frontend default-route-openshift-image-registry.apps.ocp48a.lab.upshift.rdu2.redhat.com/openshift/frontend

cd ../backend
docker build -t backend .
docker tag backend docker-registry.default.svc:5000/openshift/backend

docker tag backend default-route-openshift-image-registry.apps.ocp48a.lab.upshift.rdu2.redhat.com/openshift/backend
```
3. Log in as a user other than system:admin which has image pusher role:
```
oc login -u <user-name> -p
docker login -u <user-name> -p $(oc whoami -t) docker-registry.default.svc:5000

docker login default-route-openshift-image-registry.apps.ocp48a.lab.upshift.rdu2.redhat.com -u <user-name> -p $(oc whoami -t)
```
4. Push both images into OpenShift registry:
```
docker push docker-registry.default.svc:5000/openshift/frontend
docker push docker-registry.default.svc:5000/openshift/backend

docker push default-route-openshift-image-registry.apps.ocp48a.lab.upshift.rdu2.redhat.com/openshift/frontend
docker push default-route-openshift-image-registry.apps.ocp48a.lab.upshift.rdu2.redhat.com/openshift/backend
```

5. Create a new project, create the template and deploy the application:
```
oc new-project test-app
oc create -f frontend-backend-template.yaml
oc new-app frontend-backend
```

6. Test the application:
```
oc get route
```
In a browser: access the default index.html page and db.php page which will show the contents from backend DB.
