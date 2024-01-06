#!/bin/bash

cd $PROJECT

echo "Making settings.xml temp file"
cat <<EOF > settings.xml
    <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 
        http://maven.apache.org/xsd/settings-1.0.0.xsd">
        
        <localRepository>$($M2_WORKSPACE)/.m2</localRepository>
        
        <servers>
            <server>
                <id>lasegunda-nexus</id>
                <username>asd</username>
                <password>123</password>
            </server>
        </servers>

        <repositories>
            <repository>
                <id>lasegunda-nexus</id>
                <name>lasegunda nexus</name>
                <url>https://nexus.acme.net/content/repositories/releases</url>
            </repository>
        </repositories>
    
    </settings>
EOF

echo "/usr/bin/mvn -DskipTests clean package -gs settings.xml"
/usr/bin/mvn -DskipTests clean package -gs settings.xml

echo "Delete settings.xml temp file"
rm -fr settings.xml