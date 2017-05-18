/** WEBDRIVER SETUP - remove this section to run in New Relic Synthetics **/
var sim = require('../../lib/simulator.js');
var assert = sim.assert; var $driver = sim.driver; var $browser = sim.browser; var $util = sim.util;
/** WEBDRIVER SETUP - remove this section to run in New Relic Synthetics **/

/** CONFIGURATIONS **/

// Script-wide timeout for wait and waitAndFind functions (in ms)
var DefaultTimeout = 10000;
// Change to any User Agent you want to use.
// Leave as "default" or empty to use the Synthetics default.
var UserAgent = "default";

/** HELPER FUNCTIONS **/

var assert = require('assert'),
  By = $driver.By,
  startTime = new Date(),
  thisStep = 0,
  VARS = {};
var log = function(msg) {
    var elapsedSecs = (new Date() - startTime) / 1000.0;
    console.log('Step ' + thisStep + ': ' + elapsedSecs.toFixed(1) + 's: ' + msg);
    thisStep++;
};
// 1st log is sometimes ignored for some reason, so this is a dummy
log('init');
function isAlertPresent() {
  try {
    var thisAlert = $browser.switchTo().alert();
    return true;
  } catch (err) { return false; }
}
function isElementSelected(el) { return $browser.findElement(el).isSelected(); }
function isTextPresent(text) {
  return $browser.findElement(By.tagName('html')).getText()
  .then(function (wholetext) {
    return wholetext.indexOf(text) != -1;
  });
}

/** BEGINNING OF SCRIPT **/

// Setting User Agent is not then-able, so we do this first (if defined and not default)
if ((typeof UserAgent !== 'undefined') && (UserAgent != 'default')) {
  $browser.addHeader('User-Agent', UserAgent);
  log('Setting User-Agent to ' + UserAgent);
}

// Get browser capabilities and do nothing with it, so that we start with a then-able command
$browser.getCapabilities().then(function () { })

.then(function () {
  log('get "New Relic Synthetics homepage"');
  return $browser.get("http://newrelic.com/synthetics");
})
