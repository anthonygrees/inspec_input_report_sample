# InSpec Input Tag Sample
### Using input variables to tag reports and retrieve them via the API
An example of Chef InSpec using input variables to tag a report in Chef Automate and then pull that report via the tag on the API.

## 1. Execute InSpec profile and pass in a UUID

Run the following to execute the profile and send the results to Chef Automate.  This can be executed via a Jenkins pipeline.
```bash
inspec exec test --input deputy_id='ABCD-AB3DE-WW4RR-Ws8T9' --json-config inspec.json
```

The deputy ```control tag``` is now available

![ISM Report](/images/control-tag.png)

The ```control tag``` is now available as a filter

![ISM Report](/images/control-tag-value.png)

The Deputy control tag can now filter on the UUID provided by the Jenkins pipeline

![ISM Report](/images/control-tag-filter.png)

## 2. Find the InSpec report using the UUID via the API

Set your Chef Automate token
```bash
   export TOKEN=`sudo chef-automate iam token create demo --admin`
```

Use the Chef Automate API to list all nodes and filter on the Deputy UUID ```'{"filters":[{"type": "control_tag:deputy", "values": ["ABCD-AB3DE-WW4RR-Ws8T9"]}]}''```.
```bash
curl --silent --insecure -H "api-token: $TOKEN" https://anthony-a2.chef-demo.com/api/v0/compliance/reporting/nodes/search -d '{"filters":[{"type": "control_tag:deputy", "values": ["ABCD-AB3DE-WW4RR-Ws8T9"]}]}''
```

The output is in a ```json``` format as follows: 
```bash
{
   "nodes":[
      {
         "id":"12345678-1234-1234-1234-123456785588",
         "name":"Deputy_Node_test",
         "platform":{
            "name":"windows_server_2016_datacenter",
            "release":"10.0.14393",
            "full":"windows_server_2016_datacenter 10.0.14393"
         },
         "environment":"dev",
         "latest_report":{
            "id":"606b4656-8dc9-58a9-9d67-c6c72fa0e40a",
            "end_time":"2020-06-24T07:16:35Z",
            "status":"passed",
            "controls":{
               "total":1,
               "passed":{
                  "total":1
               },
               "skipped":{
                  "total":0
               },
               "failed":{
                  "total":0,
                  "minor":0,
                  "major":0,
                  "critical":0
               },
               "waived":{
                  "total":0
               }
            }
         },
         "tags":[

         ],
         "profiles":[
            {
               "name":"test",
               "version":"0.1.0",
               "id":"3b2d575a465052b3cf0f885a82b203874806dd87f8f5647fbc6218bd7dc8bec2",
               "status":"passed",
               "full":"InSpec Profile, v0.1.0"
            }
         ]
      }
   ],
   "total":1,
   "total_passed":1,
   "total_failed":0,
   "total_skipped":0,
   "total_waived":0
}
```
