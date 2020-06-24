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

Use the Chef Automate API to list all nodes.
```bash
curl -X POST https://automate.chef.io/api/v0/compliance/reporting/nodes/search --insecure -H "api-token: $TOKEN" -d '{"filters":[{"control tag":"deputy","values":["ABCD-AB3DE-WW4RR-Ws8T9"]}]'}'
```

You can apply as many options as required, with optional filtering, pagination, and sorting. 
```bash
{
"filters":[
{"type":"environment","values":["dev*"]},
{"type":"start_time","values":["2019-10-26T00:00:00Z"]},
{"type":"end_time","values":["2019-11-05T23:59:59Z"]}
],
"page":1,"per_page":100,
"sort":"environment","order":"ASC"
}
```
