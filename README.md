[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run)

# Using bash with Cloud Run

This code gist aims at showing the possibility to use the cloud SDK with Cloud Run.

Indeed, using one-liner CLI commands is pretty common on a day-to-day basis.
However in order to automise it with Cloud Run, it is a bit more complex.

[This repository](https://github.com/sethvargo/cloud-run-bash-example) gives a nice way to run bash commands with Cloud Run. 

If we take the same approach based on the Cloud SDK image, running gcloud, bq or gsutils commands becomes a breeze.

The target of this gist is to go one step further and actually bring the possibility to pass parameters inside the Cloud Run instance in order to get even more flexible with what we can do.

## Cloud Run prerequisites

The [Container Runtime Contract](https://cloud.google.com/run/docs/reference/container-contract) lists all the requirements our container needs to fulfill in order to be successfully deployed.

The main points are: listening where it should, and responding to requests.

## Components

### A Cloud SDK based container

The webserver is placed inside a container where the Cloud SDK is available.

In this case, the google/cloud-sdk image directly provided by Google was the perfect candidate.
Any image works fine, but in this case the alpine version was chosen in order to have the smallest possible image.

### A webserver

In order to launch bash instructions from http requests the *shell2http* tool is used. 

It is an HTTP-server (written in Go) that designed to execute shell commands. More details [here](https://github.com/msoap/shell2http).

With the `cgi` flag, the incoming requests are redirected into the stdin of the bash script, therefore with a bit of processing it is possible to extract any necessary information form that request and run a GCP command with specified parameters.

## Use case

A few use cases can be envisioned with this tool:

* bq load jobs triggered by flat files uploaded to a GCS bucket,
* back-up operations from database instances to GCS,
* triggering of Google Workflows based on specific events (with eventarc triggers for instances)
* etc

## Deployment

Cf Makefile

It assumes there is an active GCP project with the project variable set.
Cloud Run needs to be enabled.
