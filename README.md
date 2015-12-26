[![ghit.me](https://ghit.me/badge.svg?repo=slariviere/letsencrypt-renwal)](https://ghit.me/repo/slariviere/letsencrypt-renwal)

# letsencrypt-renwal
Renew letsencrypt certificates with custom renew scripts for each domains.

# Usage:
Set a cronjob:
```
1 2 * * * /home/slariviere/scripts/letsencrypt-renwal.sh
```
This will check on the certificate expiration date, if it's near expiration, it will run the custom renew script.

A custom renew script is needed for each domain. By default, it checks in `/etc/letsencrypt/live/<domain>/letsencrypt-renewal.sh`.

## Sample of a custom script:
```
#!/bin/bash
cd ~/letsencrypt/ && ./letsencrypt-auto certonly --standalone -d sebastienlariviere.com -d www.sebastienlariviere.com --renew-by-default
```
