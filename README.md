# .jr_env

### setup

run this command in bash:

```bash

$ source <(curl -s https://raw.githubusercontent.com/jrhea/.jr_env/master/sync-repo.sh)

```

or 

```bash

$ bash <(curl -s https://raw.githubusercontent.com/jrhea/.jr_env/master/sync-repo.sh)

```
  
### issues

if you know that you work in an environment that self-signs certificates and you want to clone this repo then workaround is to disable Git SSL verfication:

```bash

$ git config --global http.sslVerify false

```
