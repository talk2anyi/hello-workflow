# Wafi Hello-workflow Task

This is a rundown for the different stages of the task.

NB: All relevant files for the application have been included in the repo.

## Deploy a temporal cluster for production.

The Temporal production cluster was deployed on kubernetes using Helm Charts from here: `https://github.com/temporalio/helm-charts` 

Here's the output of: `kubectl --namespace=default get pods -l "app.kubernetes.io/instance=temporaltest"` to verify that Temporal has started:

```
NAME                                              READY   STATUS    RESTARTS      AGE
temporaltest-admintools-c9d4bff9-lnmt6            1/1     Running   0             20m
temporaltest-frontend-6755f45bb5-6jb4p            1/1     Running   3 (17m ago)   20m
temporaltest-grafana-5c5fd8dbc5-525xv             1/1     Running   0             20m
temporaltest-history-584b4d4754-kdc44             1/1     Running   3 (17m ago)   20m
temporaltest-kube-state-metrics-fdcdccf7f-h248x   1/1     Running   0             20m
temporaltest-matching-5db7f9f7d8-f789c            1/1     Running   3 (17m ago)   20m
temporaltest-web-856996888b-cbwbs                 1/1     Running   0             20m
temporaltest-worker-68c887bc65-4pkxp              1/1     Running   3 (17m ago)   20m
```

## Package the Temporal app as a docker image.

Here's the `Dockerfile` used to build the image for the hello-workflow application: 

```
# syntax=docker/dockerfile:1
FROM golang:1.16-alpine
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o .
EXPOSE 8080 7233
CMD [ "./worker/main.go" "./starter/main.go" ]
```

## Write a CICD pipeline for the Application.

Jenkins was used to build a pipeline that polls github for code updates, build the latest version of the application and push to DockerHub after which it deploys the app to kubernetes. 

You can find the pipeline script in the `jenkinsfile`.


## Deploy the application using kubernetes.

A deployment file `hello-workflow.yml` was wriiten for jenkins to poll and deploy the application to a kubernetes cluster.


## How would you improve the app?

To improve the hello-workflow application, here are a few things that can be done:

- Add more functionality: You could add more functionality to the workflow, such as interacting with external systems, handling errors and retries etc.

- Add unit tests: Adding unit tests to the application would be a good way to verify that the code is working correctly, and to ensure that any changes or updates to the code don't introduce new bugs or issues.












