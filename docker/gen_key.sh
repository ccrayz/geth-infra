#!/bin/bash

mkdir -p keys
openssl rand -hex 32 > keys/jwt-secret.txt
