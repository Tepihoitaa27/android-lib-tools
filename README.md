# android-lib-tools
Stuff for publishing android libs to own artifactory repository


## Usage

### Install
```bash
cd /path/to/project
git submodule add https://github.com/edwardstock/android-lib-tools.git scripts
```

 * Add publishing config into module build.gradle
```groovy

buildscript {
    dependencies {
        classpath "org.jfrog.buildinfo:build-info-extractor-gradle:4.21.0"
    }
}

apply plugin: 'maven'
apply plugin: 'maven-publish'
apply plugin: 'com.jfrog.artifactory'

// maven config
group = "my.company.android"
version = "1.0.0"

ext {
    buildArtifactName = project.name
    buildArtifactVersion = version
    buildArtifactGroup = group

    pomName = "My Super Library"
    pomUrl = "https://github.com/myteam/mylib"
    pomScm = {
        connection = "scm:git:git://github.com/myteam/mylib.git"
        url = pomUrl
    }
    pomInceptionYear = "2018"
    pomContributors = {}
    pomDescription = "Description for my superlib"
    pomDevelopers = {
        developer {
            id = "username"
            name = "Name Lastname"
            email = "email@gmail.com"
            roles = ["maintainer"]
            timezone = "Europe/Moscow"
        }
    }
    pomLicenses = {
        license {
            name = "MIT License"
            url = "https://opensource.org/licenses/MIT"
            distribution = "repo"
        }
    }
}
```

 * Add to end of your `build.gradle`
```groovy
apply from: 'scripts/maven_publish.gradle'
```


### Usage
```bash
./scripts/publish --help
```
