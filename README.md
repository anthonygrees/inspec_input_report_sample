# inspec_input_report_sample
An example of Chef InSpec using inputs and reporting in Chef Automate

## Execute InSpec profile and pass in a UUID

Run the following to execute the profile and send the results to Chef Automate
```bash
inspec exec test --input deputy_id='ABCD-AB3DE-WW4RR-Ws8T9' --json-config inspec.json
```

## Find the InSpec report using the Deputy_ID via the API

Set your Chef Automate token
```bash
   export TOKEN=`sudo chef-automate iam token create demo --admin`
```

Use the Chef Automate API to list all nodes.
```bash
curl -X POST https://automate.chef.io/api/v0/compliance/reporting/nodes/search --insecure -H "api-token: $TOKEN" -d '{"filters":[{"type":"environment","values":["dev*"]}]'}'
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
