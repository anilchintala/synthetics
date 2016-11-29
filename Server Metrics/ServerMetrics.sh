// Global variables we'll need
var config = {
  "name": "myapm-server-to-insights",
  "EVENT_NAME": "Serverdata",
  "ACCOUNT_ID": "[ACCOUNT_ID]",  
  "QUERY_KEY_INSIGHTS": "[QUERY_KEY_INSIGHTS]",
  "INSERT_KEY_INSIGHTS": "[INSERT_KEY_INSIGHTS]",
  "REST_API_KEY": "[REST_API_KEY]"
};

var maxTime = 0;
var servers = [];

var serverListOpts = {
  uri: 'https://api.newrelic.com/v2/servers.json',
  headers: {'Accept': 'application/json', 'X-Api-Key': config.REST_API_KEY} };

var maxTimeOpts = {
    uri: 'https://insights-api.newrelic.com/v1/accounts/' + config.ACCOUNT_ID + '/query',
    headers: {'Accept': 'application/json', 'X-Query-Key': config.QUERY_KEY_INSIGHTS},
    qs: {'nrql': 'SELECT max(timestamp) FROM ' + config.EVENT_NAME} };

var metricArr = [
{title: 'CPU System', metric: 'System/CPU/System/percent', value: 'average_value'},
{title: 'CPU User', metric: 'System/CPU/User/percent', value: 'average_value'},
{title: 'Memory Used', metric: 'System/Memory/Used/bytes', value: 'average_value'},
{title: 'Swap Used', metric: 'System/Swap/Used/bytes', value: 'average_value'},
{title: 'Disk Utilization', metric: 'System/Disk/All/Utilization/percent', value: ''},
{title: 'Network Received', metric: 'System/Network/All/Received/bytes/sec', value: 'total'},
{title: 'Network Transmitted', metric: 'System/Network/All/Transmitted/bytes/sec', value: 'total'} ];

// Insert the collected data for this server into Insights
function insertServerData(server, data) {
  
  var serverName = server.name;
  var metrics = data.metric_data.metrics;
  var eventArr = [];

  // Loop through the metrics
  for (var i = 0; i < metrics.length; i++) {
    console.log('Metric name: ' + metrics[i].name + ' slices: ' + metrics[i].timeslices.length);
    var metricName = metricArr[i].title;
    var timesliceArr = metrics[i].timeslices;

    // Loop through the timeslices
    for (var j = 0; j < timesliceArr.length; j++) {
      
      var iEvent = {};
      if (i === 0) {
        eventArr[j] = iEvent;
      } else {
        iEvent = eventArr[j];
      }

      var timeslice = timesliceArr[j];
      var ts = new Date(timeslice.to).getTime();
      var metricValue = timeslice.values.average_value;
      if (metricArr[i].value == 'total') {
        metricValue = timeslice.values.total;
      }

      iEvent['eventType'] = config.EVENT_NAME;
      iEvent['timestamp'] = ts;
      iEvent['Server'] = serverName;
      iEvent[metricName] = metricValue;
    }

  }
  // console.log(eventArr);

  // Setup the Insights insert options
  var options = {
    uri: 'https://insights-collector.newrelic.com/v1/accounts/' + config.ACCOUNT_ID + '/events',
    headers: {'X-Insert-Key': config.INSERT_KEY_INSIGHTS},
    json: true,
    body: eventArr
  };

  $http.post(options, function(error, response, body) {
    if (!error && response.statusCode == 200) {
      console.log('Data imported to Insights successfully');
    } else {
      console.log('Insights POST error: ' + response.statusCode);
      console.log(response.body);
    }
  });
}

function queryServer(server) {
  var serverId = server.id;
  console.log('Query Server: ' + server.name);
  
  // Make the properly formatted timestamp
  var ts = Date.now() - (60 * 60 * 1000);
  if (maxTime > 0) { ts = maxTime + 60000; }
  var fromUTC = new Date(ts).toISOString();
  
  // Make the request body of all the metrics and time
  var namesArr = [];
  for (var i=0; i < metricArr.length; i++) {
    namesArr.push( metricArr[i].metric );
  }

  // Make the HTTP Request options
  var metricOpts = {
    uri: 'https://api.newrelic.com/v2/servers/' + serverId + '/metrics/data.json',
    headers: {'Accept': 'application/json', 'X-Api-Key': config.REST_API_KEY},
    qsStringifyOptions: { arrayFormat: 'brackets' },
    qs: {
      'names': namesArr,
      'from': fromUTC
    }
  };

  // Request the metrics for this server
  $http.get(metricOpts, function(error, response, body) {
    if (!error && response.statusCode == 200) {
      var data = JSON.parse(body);
      insertServerData(server, data);
    } else {
      console.log('Query Server error: ' + response.statusCode);
      console.log(response.body);
    }
  });
}

// This code actually runs first and gets the server list and Max Time from Insights
$http.get(serverListOpts, function (error, response, body) {
  if (!error && response.statusCode == 200) {
    servers = JSON.parse(body).servers;
    console.log('Inside server count: ' + servers.length);
    
    // Get the Max Time
    $http.get(maxTimeOpts, function(error, response, body) {
      if (!error && response.statusCode == 200) {
        maxTime = JSON.parse(body).results[0].max;

        // Query the Server Metrics
        for (var i=0; i < servers.length; i++) {
          // console.log(servers[i])
          queryServer(servers[i]);
        }
      } else {
        console.log('Query Max Time error: ' + error);
      }
    });
  } else {
    console.log('Query Server List error: ' + error);
  }
});
