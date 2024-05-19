# Custom nginx docker image

This project is how to add modules to original docker image of nginx.

The goal is to remove "Server" header from basic response.

Based on nginx:1.21.4-alpine and headers-more-nginx-module

This version used because it is last in compability list of using module.

The check_header_server.sh script is for checking that the header exists.
