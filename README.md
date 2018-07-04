# android-lib-tools
Stuff for publishing android libs


## Usage

### Install
```bash
cd /path/to/project
git submodule add https://github.com/MinterTeam/android-lib-tools.git scripts
```

 * Add publishing config
```groovy

apply plugin: 'maven'
apply plugin: 'maven-publish'

// maven config
group = "my.company.android"
version = "1.0.0"

// minter_publish.gradle config
ext {
	pomDescription="Description for pom"
}
```

 * Add to end of your `build.gradle`
```groovy
apply from: 'scripts/minter_publish.gradle'
```


### Usage
```bash
./scripts/publish --help
```
