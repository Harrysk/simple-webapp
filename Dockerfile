apiVersion: build.openshift.io/v1
kind: BuildConfig
metadata:
  name: simple-web-app-docker
spec:
  output:
    to:
      kind: ImageStreamTag
      name: 'simple-web-app-docker:latest'
  runPolicy: Serial
  source:
    git:
      ref: master
      uri: 'https://github.com/Harrysk/simple-webapp.git'
    type: Git
  strategy:
    sourceStrategy:
      from:
        kind: ImageStreamTag
        name: 'python:3.6'
        namespace: openshift
    type: Source
  triggers:
    - imageChange:
        lastTriggeredImageID: >-
          172.30.1.1:5000/openshift/python@sha256:1bd1b12c9095a6356959984fee6f10a77e98f1be75431d1145b9382dba578233
      type: ImageChange
    - type: ConfigChange
    - generic:
        secret: 96e61f36a6706aae
      type: Generic
    - github:
        secret: 1c143b4f18446827
      type: GitHub
status:
  lastVersion: 2
