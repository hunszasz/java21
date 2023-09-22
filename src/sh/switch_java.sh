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

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" == "1.8"* ]]; then
        echo version is 1.8
    elif [[ "$version" == "1."* ]]; then
        echo version is less than 1.8
    else
	echo version is newer than 1.8
    fi
fi

echo 'do not forget:'
echo 'source /etc/profile.d/java_home.sh'
