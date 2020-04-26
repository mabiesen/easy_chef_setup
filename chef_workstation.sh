# generic updates
sudo apt-get update
sudo apt-get upgrade

#installation
wget https://packages.chef.io/files/stable/chef-workstation/0.2.43/ubuntu/18.04/chef-workstation_0.2.43-1_amd64.deb
sudo dpkg -i chef-workstation_*.deb
rm chef-workstation_*.deb

# scaffolds repository.  This is primarily where you will work from
chef generate repo chef-repo

# this was written stupidly due to permissions hangup, sudo wasnt sufficient to append the file
echo "$(hostname -I) $(hostname)" | sudo tee -a /etc/hosts

cd chef-repo
mkdir .chef

# generate id_rsa
ssh-keygen -b 4096

# configure git
git config --global user.name mbiesen
git config --global user.email mbiesen@enova.com
git add .
git commit -m "initial commit"

echo -e "\n\nSetup script has completed\nExecute rest of the file manually for now"

# in ~/chef-repo/.chef, create config.rb with the following
##
#current_dir = File.dirname(__FILE__)
#log_level                :info
#log_location             STDOUT
#node_name                'mbiesen'
#client_key               "mbiesen.pem"
#validation_client_name   'cheftestorg-validator'
#validation_key           "cheftestorg-validator.pem"
#chef_server_url          'https://mbiesen-chefserver.dev.enova.com/organizations/cheftestorg'
#cache_type               'BasicFile'
#cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
#cookbook_path            ["#{current_dir}/../cookbooks"]



# manually copy id_rsa.pub of the workstation to authorized_keys of the server
# Then run this:
# scp mbiesen@mbiesen-chefserver.dev.enova.com:~/.chef/*.pem ~/chef-repo/.chef/

# then we are going to secure ssl
# cd ~/chef-repo
# knife ssl fetch

# set up your test node.  get it running and upgrade it
# copy your id_rsa.pub to the new nodes authorized keys

# after you testnode is running, run the following.  You'll be prompted for password, hit enter a bunch of times
# knife bootstrap 10.110.32.53 --ssh-user mbiesen --sudo --identity-file ~/.ssh/id_rsa.pub --node-name mbiesen-chefnode

# NOTE:  new workstations must have their id_rsa.pubs added to the nodes??? ssh would break for me otherwise, ask for password, even with identity file args
