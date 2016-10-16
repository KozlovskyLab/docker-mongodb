===================
Dockerizing MongoDB
===================

:Author: Vladimir Kozlovski
:Contact: inbox@vladkozlovski.com
:Issues: https://github.com/vladkozlovski/docker-mongodb/issues
:Docker image: https://hub.docker.com/r/vladkozlovski/mongodb/
:Description: Dockerfile to build a MongoDB container image which can be 
              linked to other containers.

:Release notes: https://docs.mongodb.org/master/release-notes/
:Official image: https://hub.docker.com/_/mongo/
:Official GitHub: https://github.com/mongodb/mongo


.. meta::
   :keywords: MongoDB, Mongo, Docker, Dockerizing
   :description lang=en: Dockerfile to build a MongoDB container image which 
                         can be linked to other containers.

.. contents:: Table of Contents


Introduction
============

Dockerfile to build a MongoDB container image which can be linked to other 
containers.


Installation
============

Pull the latest version of the image from the docker index. This is the 
recommended method of installation as it is easier to update image in the 
future.
::
    docker pull vladkozlovski/mongodb:latest

Alternately you can build the image yourself.
::
    git clone https://github.com/vladkozlovski/docker-mongodb.git
    cd docker-mongodb
    docker build -t="$USER/mongodb" .


Quick Start
===========
Run the MongoDB image
::
    docker run -p 127.0.0.1:27017:27017 --name mongodb -d vladkozlovski/mongodb:latest

to support persistent storage of data:
::
    -v <data-dir>:/data/db

for time synchronization with local:
::
    -v /etc/localtime:/etc/localtime:ro

Run the MongoDB image with all features:
::
    docker run -p 127.0.0.1:27017:27017 -v <data-dir>:/data/db -v /etc/localtime:/etc/localtime:ro --name mongodb -d vladkozlovski/mongodb:latest


Upgrading
=========
To upgrade to newer releases, simply follow this 3 step upgrade procedure.

* **Step 1:** Stop the currently running image::

    docker stop mongodb


* **Step 2:** Update the docker image::

    docker pull vladkozlovski/mongodb:latest


* **Step 3:** Start the image::

    docker run -p 127.0.0.1:27017:27017 --name mongodb -d vladkozlovski/mongodb:latest
