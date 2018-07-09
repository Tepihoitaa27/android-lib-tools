#!/usr/bin/env bash

function capitalize() {
  local outRes=$(echo ${1} | awk '{ for ( i=1; i <= NF; i++) {   sub(".", substr(toupper($i),1,1) , $i)  } print }')
  echo "${outRes}"
}

gradlePath="${PWD}/gradlew"
flavor=""
artifactSuffix=""
artifactSuffixPom=""
projectName=$(${gradlePath} projects | grep "Root project '" | awk -F "'" '{print $2}')
artifactName=${projectName}

function clean() {
    ./gradlew :clean
}

function usage() {
    echo "Minter local maven publishing script"
    echo ""
    echo "./publish.sh"
    echo "    -h --help         Print this help"
    echo "    -p --project      Project artifact name (current: ${projectName})"
    echo "       --list-flavors Print flavors list"
    echo "    -f --flavor       Choose flavor name by \"--list-flavors\""
    echo "    -s --suffix       Artifact suffix"
    echo "    -n --name         Artifact name (using instead of project.name)"
    echo "       --clean        Clean build"
    echo ""
}

function printFlavors() {
    ./gradlew printFlavors
}

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    usage
    exit
    ;;
    --list-flavors)
    printFlavors
    exit
    ;;
    --clean)
    clean
    exit
    ;;
    -s|--suffix)
    artifactSuffix="$2"
    shift # past argument
    shift # past value
    ;;
    -n|--name)
    artifactName="$2"
    shift # past argument
    shift # past value
    ;;
    -f|--flavor)
    flavor="$2"
    shift # past argument
    shift # past value
    ;;
esac
done

flavorCap=$(capitalize ${flavor})
projectNameCap=$(capitalize ${projectName})


if [ "${artifactSuffix}" != "" ]
then
    artifactSuffixPom="-${artifactSuffix}"
fi

if [ "${flavor}" == "" ]
then
    echo "Flavor can't be empty"
    exit 1
fi

if [ "${projectName}" == "" ]
then
    echo "Project name (artifact id) required!"
    exit 1
fi

${gradlePath} -PbuildFlavor=${flavor} -PartifactSuffix=${artifactSuffix} -PbuildArtifactName=${artifactName} \
    :assemble${flavorCap} \
    :androidSources :androidJavadoc :androidJavadocJar \
    :generatePomFileFor${projectNameCap}${artifactSuffixPom}Publication \
    :publishToMavenLocal