# Synthetics Scripts Depot
Example synthetic scripts for interesting sites. Please feel free to contribute!

## Pre-requisites
In order to get setup with Synthetics so they can run local on your machine.

### Get the source

Download

 and unzip or use git:
```
git clone
```
### Install Node on Mac and/or PC
```
https://nodejs.org/en/
```

### Install Dependencies
```
cd synthetics-scripts
npm install
```

### Install Chrome Driver (via installer for Mac and/or PC place it in C:\Windows)
https://sites.google.com/a/chromium.org/chromedriver/downloads

### Run test.js on your machine like this:
```
$user:synthetics-scripts/$ node test.js
```

### See a Chrome window pop up?
Then your local synthetics development environment is working!

### This code powers test.js
```
var assert = require('assert'), $driver = require('selenium-webdriver');
var $browser = new $driver.Builder().forBrowser('chrome').build();

$browser.get('http://newrelic.com/synthetics');
```

### Make Your Own Web Script
Now you can make your own scripts, you need those first 2 lines to setup local variables for $driver and $browser. Just make a copy of 0-template (call it whatever you like) and start editing the scripts. If it works and is cool, when you're done check it back in!
```
synthetics-scripts user$ cp -R 0-template/ myproject
synthetics-scripts user$ cd myproject/
myproject user$ ls -al
total 16
drwxr-xr-x  4 user  staff   136 Jul 22 16:30 .
drwxr-xr-x  9 user  staff   306 Jul 22 16:30 ..
-rw-r--r--  1 user  staff   509 Jul 22 16:30 api.js
-rw-r--r--  1 user  staff  1891 Jul 22 16:30 web.js
```
Then start editing web.js with the proper values for your scenario.

### Make It Run in Synthetics
OK, so it's nice to develop locally but you want to run it in New Relic Synthetics. What you need to do now is to skip the first section (WEBDRIVER SETUP) and paste the rest of the script into Synthetics. If it's an API test it should just run as-is. Good luck!

# What About API Tests?
Take a look at the template project. There is also api.js which sets up the $http object that is used by Synthetics. Same principles as a Browser Script.

### Other libraries
New Relic Synthetics offers lots of other libraries, if you need those for your local development you may need to install them as well.
https://docs.newrelic.com/docs/synthetics/new-relic-synthetics/scripting-monitors/import-nodejs-modules

# Examples
### Work in Progress
Script Name           | Functionality               | Link to Script           
----------------------|-----------------------------|-------------------
 | | | |
 | | | |
