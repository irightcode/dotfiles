#!/bin/bash


echo JAVA_HOME: $JAVA_HOME

FILE=$1
ALIAS=$2
KEYTOOL=$JAVA_HOME/bin/keytool
CACERTS=$JAVA_HOME/lib/security/cacerts
SUDO=

if [ ! -f "$FILE" ]; then
  echo "$FILE does not exist."
  exit 1
fi

if [ -z "$ALIAS" ]; then
  echo "alias required."
  exit 1
fi

if [ ! -w "$CACERTS" ]; then
  SUDO=sudo
fi

# $SUDO keytool -import -cacerts -alias $ALIAS -keystore $CACERTS -file "$FILE" -storepass changeit
$SUDO keytool -import -cacerts -alias $ALIAS -file "$FILE" -storepass changeit


