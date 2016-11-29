New Relic Sythetics Server Metrics
=========

The goal of this Synthetics script is to pull in Server metrics at a specific 
interval into New Relic Insights. This allows customers to control the
volume of the data going into Insights as well as filter to specific hosts.

Status
------

Working for several clients, please see the example Insights dashboard below.


Installation
------------

Create a custom API Synthetics test. Set the frequency to >1 hour and one test location. No need to alert on failure.


Sample Insights Dashboard
-------------

Copy and paste the following into your Insights account:

```
{"account_id":436109,"title":"Server Data","icon":"bar-chart","filter":{"id":36141,"dashboard_id":99801,"key_names":[],"event_types":["Serverdata"],"filter_first":false,"description":{"plural":"","singular":""},"escaped_event_types":"`Serverdata`"},"widgets":[{"title":"System CPU Heatmap","nrql":"SELECT histogram(`CPU System`,.5,100) FROM Serverdata facet Server","has_empty_result":null,"process_as":"heatmap","account_id":436109,"width":1,"height":1,"row":1,"column":1,"event_types":["Serverdata"],"facet":"Server","is_alertable":false,"customizations":{},"notes":null,"feature_flag":"heatmap_widget"},{"title":"Maximum Server Memory","nrql":"SELECT max(`Memory Used`),  average(`Memory Used`) from Serverdata facet Server since 1 day ago","has_empty_result":null,"process_as":"facet_table","account_id":436109,"width":1,"height":1,"row":1,"column":2,"event_types":["Serverdata"],"facet":"Server","is_alertable":false,"customizations":{},"notes":null},{"title":"User CPU","nrql":"SELECT average(`CPU User`) FROM Serverdata FACET Server","has_empty_result":null,"process_as":"facet_bar_chart","account_id":436109,"width":1,"height":1,"row":1,"column":3,"event_types":["Serverdata"],"facet":"Server","is_alertable":false,"customizations":{"drilldown":{"dashboard_id":89383}},"notes":null,"feature_flag":"facet_bar_chart_widget"},{"title":"Swap Used","nrql":"SELECT average(`Swap Used`) FROM Serverdata FACET Server","has_empty_result":null,"process_as":"facet_bar_chart","account_id":436109,"width":1,"height":1,"row":2,"column":1,"event_types":["Serverdata"],"facet":"Server","is_alertable":false,"customizations":{},"notes":null,"feature_flag":"facet_bar_chart_widget"},{"title":"Average System CPU","nrql":"SELECT average(`CPU System`) FROM Serverdata FACET Server TIMESERIES","has_empty_result":false,"process_as":"faceted_area_chart","account_id":436109,"width":2,"height":1,"row":2,"column":2,"event_types":["Serverdata"],"facet":"Server","is_alertable":false,"customizations":null,"notes":null},{"title":"Memory Used","nrql":"SELECT average(`Memory Used`) FROM Serverdata FACET Server","has_empty_result":null,"process_as":"facet_bar_chart","account_id":436109,"width":1,"height":1,"row":3,"column":1,"event_types":["Serverdata"],"facet":"Server","is_alertable":false,"customizations":{},"notes":null,"feature_flag":"facet_bar_chart_widget"},{"title":"User CPU","nrql":"SELECT average(`CPU User`) FROM Serverdata FACET Server TIMESERIES","has_empty_result":false,"process_as":"faceted_area_chart","account_id":436109,"width":2,"height":1,"row":3,"column":2,"event_types":["Serverdata"],"facet":"Server","is_alertable":false,"customizations":null,"notes":null}]}
```


Contributions
-------------

The original script is from Swati Joshi on the New Relic Expert Services team. Swati also developed the Insights Server Dashboard.

Contributions are more than welcome. Bug reports with specific reproduction
steps are great. If you have a code contribution you'd like to make, open a
pull request with suggested code.

Pull requests should:

 * Clearly state their intent in the title
 * Have a description that explains the need for the changes
 * Include tests!
 * Not break the public API
 * Add yourself to the CONTRIBUTORS file. I might forget.

If you are simply looking to contribute to the project, taking on one of the
items in the "Future Additions" section above would be a great place to start.
Ping us to let us know you're working on it by opening a GitHub Issue on the
project.

By contributing to this project you agree that you are granting New Relic a
non-exclusive, non-revokable, no-cost license to use the code, algorithms,
patents, and ideas in that code in our products if we so choose. You also agree
the code is provided as-is and you provide no warranties as to its fitness or
correctness for any purpose

Copyright (c) 2014-2015 New Relic, Inc. All rights reserved.
