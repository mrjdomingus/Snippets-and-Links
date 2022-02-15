# How to view currently running cron jobs?

To check if cron is actually running anything at this moment in time (works on ubuntu)
```
pstree -apl `pidof cron`
```
and you'll either get

`2775,cron` # your pid (2775) will be different to mine :-)<br><br>
or a tree output with all the child processes that cron is running (it may not name them if you don't have sufficient privileges) and the logs are in `/var/log/syslog` so

`grep CRON /var/log/syslog`<br>
will get you the logs just for cron
