# generic application updates
sudo apt-get update
sudo apt-get upgrade

# server installation
sudo wget https://packages.chef.io/files/stable/chef-server/13.0.17/ubuntu/18.04/chef-server-core_13.0.17-1_amd64.deb
sudo dpkg -i chef-server-core_*.deb
rm chef-server-core_*.deb

sudo chef-server-ctl reconfigure

mkdir .chef

# creating the user and org
sudo chef-server-ctl user-create mbiesen matthew biesen mbiesen@gmail.com 'password' --filename ~/.chef/mbiesen.pem
sudo chef-server-ctl org-create cheftestorg "cheftestorg" --association_user mbiesen --filename ~/.chef/cheftestorg.pem

# to get the front end up and running
sudo chef-server-ctl install chef-manage
sudo chef-server-ctl reconfigure 
sudo chef-manage-ctl reconfigure 
