New Relic Synthetics
=========

The goal of this GIT Repo is to have a collection of New Relic Synthetic scripts
which can be used to run common or repetitive tasks. Synthetics is the New Relic 
swiss army knife with excellent integration with New Relic Insights. In most 
cases you will need to log in with your personal account due to New Relic 
employee restrictions on the Synthetics product.

Please feel free to clone this repo and customize it to your specific needs.

Most importantly, share your ideas with customers!

Status
------

The New Relic Synthetics API is a great place to create and test your automation: 
https://rpm.newrelic.com/api/explore/

Once the script is created you can use an application like Postman to
automate the creation of *standard* Synthetic monitors to do things like:
- Creating monitors against the New Relic Insights API
- Running scripts at specific intervals including - server metrics, automated 
load tests (calling BlazeMeter for example)


Installation
------------

Please install the Postman REST client-  www.getpostman.com

Contributions
-------------

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
