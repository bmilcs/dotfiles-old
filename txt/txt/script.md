# SCRIPT

## CLOUDFLARED

- add diff functionality between: `/etc/nginx/sites-enabled/bmilcs` 
  and the output of cloudflared api script: `~/bmP/bin/cloudflared/info`

#### 1. regex: parse nginx config

  * delete lines NOT containing server_name
  * delete `server_name` & `;`
  * remove domain suffix: `.bmilcs.com`
  * rm leading/trailing spaces
  * swap spaces with new lines
  * sort alphabetically

#### 2. regex: parse cloudflared `. info` stdout
  
  * rm non-essential output:
    * lines starting with: _
      * DNS acme challenges
      * SRV lines
  * sort subdomains alphabetically

#### 3. diff: nginx conf & cloudflare subdomains

  * populate variable with missing subdomains
  * `for loop` & run `cfadd` for missing CNAMES
  * stdout: success or failure
  * add all new subdomains to final output list
  * save list of current subdomains to log file for reference

