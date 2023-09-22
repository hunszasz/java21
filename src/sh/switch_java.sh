#!/bin/bash

sudo alternatives --config java <<< $1
sudo alternatives --config javac <<< $1
sudo alternatives --config jar <<< $1

echo 'switchJava: '$(which javac)
echo 'switchJava: '$(readlink $(which javac))
echo 'switchJava: '$(readlink $(readlink $(which javac)))
echo 'switchJava: '$(dirname $(readlink $(readlink $(which javac))))
echo 'switchJava: '$(dirname $(dirname $(readlink $(readlink $(which javac)))))

echo 'export JAVA_HOME='$(dirname $(dirname $(readlink $(readlink $(which javac))))) > /etc/profile.d/java_home.sh

java -version
javac -version
echo 'JAVA_HOME: '$JAVA_HOME
mvn -v


if type -p java; then
    echo found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME
    _java="$JAVA_HOME/bin/java"
else
    echo "no java"
fi

echo 'do not forget:'
echo 'source /etc/profile.d/java_home.sh'
