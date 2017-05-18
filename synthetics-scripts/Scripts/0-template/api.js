/** API SETUP - remove this section to run in New Relic Synthetics **/
if ($http == null) { var $http = require('request'); }
/** API SETUP - remove this section to run in New Relic Synthetics **/

var options = {
  'method': 'GET',
  'uri': 'http://jsonip.com',
  'headers': null,
  'qs': null,
  'json': true
};

$http(options, function (error, response, body) {
  if (!error && response.statusCode == 200) {
    if (response.statusCode == 200) {
      console.log('Your IP is: ', body.ip);
    } else {
      console.log('Non-200 HTTP response: ' + response.statusCode);
    }
  } else {
    console.log(error);
  }
});
