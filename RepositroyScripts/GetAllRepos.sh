#!/bin/bash

#This Script is designed to pull all repositories from a specified Security Center using the standard Tenable API authentication


#First, define some variables to use for authentication and location of the Security Center

url=""
accessKey=""
secretKey=""

#Now, request input via console, via the read command with a -p flag to allow for a prompt and store response in the variables defined earlier

read -p "URL of the Tenable.SC (https://hosntame)" url
read -p "Access Key for an admin user for the specified Tenable.SC" accessKey

#We will so the same thing again but will add the -s option to hide the input given for our Secret Key

read -sp "Secret Key for an admin user for the specified Tenable.SC" secretKey


#Now we are going to send our request using cURL and pass through the data collected above to the REST API of the Tenable.SC and return the data formatted into a JSON file format. 
#Tenable.SC natrually returns GET requests in a JSON format and makes it easier to then sift through items later on if needed
#Using the python json tool is how it will output to a file called "repositories.json" 

curl --request GET \
     --insecure \
     --globoff \
     --url $url/rest/repository \
     --header "x-apikey: accesskey=$accessKey; secretKey=$secretKey" \
     |python -m json.tool > repositories.json

# This is optional, however it is good to see right away if there are error codes from a possible incorrect API key that was used

cat repositories.json