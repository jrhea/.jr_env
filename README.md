# wherever you go there you are

this is the only place that i know my wife won't reorganize when i am not looking

## how to use this environment

1. clone the repo 

  `$ git clone https://github.com/jrhea/.jr_env.git`

2. run init script
  
  `$ source ~/.jr_env/init.env`
  
## project structure

* config: settings files (e.g. .bashrc, .cshrc, .conf files)

* utils: code/scripts i use regularly, or that i just don't want to lose 

## issues

if you know that you work in an environment that self-signs certificates and you want to clone this repo then workaround is to disable Git SSL verfication:

  `$ git config --global http.sslVerify false`

> #### disclaimer: i am not recommending that you do this and i do not take responsibility if something bad happens.  catch me if you can
