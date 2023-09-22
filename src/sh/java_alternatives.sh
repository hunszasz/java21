#!/bin/sh

alternatives --remove-all java
alternatives --remove-all javac
alternatives --remove-all jar

declare -A JAVA_HOMES

JAVA_HOMES["java21"]='/usr/lib/jvm/java-21-openjdk-*/bin'
JAVA_HOMES["java17"]='/usr/lib/jvm/java-17-openjdk-*/bin'
JAVA_HOMES["java11"]='/usr/lib/jvm/java-11-openjdk-*/bin'
JAVA_HOMES["java1_8"]='/usr/lib/jvm/java-1.8.0-openjdk-*/bin'

to_set="java21"

var=9999

keys=( $( echo ${!JAVA_HOMES[@]} | tr ' ' $'\n' | sort -r) )

for i in ${keys[@]}
do
  echo "set alternatives to: $i"

  alternatives --install /usr/bin/java java ${JAVA_HOMES[$i]}/java $var
  alternatives --install /usr/bin/javac javac ${JAVA_HOMES[$i]}/javac $var
  alternatives --install /usr/bin/jar jar ${JAVA_HOMES[$i]}/jar $var
  
  if [[ to_set == $1 ]]; then
    alternatives --set java ${JAVA_HOMES[$i]}/java
    alternatives --set javac ${JAVA_HOMES[$i]}/javac
    alternatives --set jar ${JAVA_HOMES[$i]}/jar
  fi

  var=$((var-1))
done