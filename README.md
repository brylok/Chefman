# Chefman
An environment built by Chef for working with Middleman 4.

## Getting Started with Vagrant Chef


### Clone the vagrant chef repo
`git clone git@github.com:brylok/Chefman.git`

### Move into the new folder
`cd chefman/`

### Clone the Middleman project repo you want to work on
`git clone git@github.com:brylok/GulpMan.git`

### Download and provision vm
`vagrant up`

### Connect to vm
`vagrant ssh`

### Move to your app folder
`cd ../../vagrant/Gulpman`

### Run your app installs
`bundle install`
`npm install`
`sudo npm install gulp -g`

### Start the Middleman app
`rake preview`

### View running app in your browser
http://localhost:4567



## Deployment

### Install Aws CLi
`sudo apt-get install -y python-pip`

`sudo pip install awscli`

### Create aws-cli folder/file
`mkdir ~/.aws`

`touch ~/.aws/config`

### Copy in AWS keys
`vi ~/.aws/config`


### Protect the key folder

`chmod 600 ~/.aws/config`


### Deploy

`rake deploy:production`

