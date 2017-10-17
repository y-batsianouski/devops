## Owerview

Setup nomad cluster with consul as service discovery and vault as a secret-storage.
The next VMs are startup:
  - 3 master nodes (serve Consul servers, Nomad servers, Vault servers)
  - 4 private agent nodes (serve Consul agents, Nomad agents)
  - 1 public node (serve Consul agents, Nomad agents)
  - devmachine for using UNIX-tools on windows workstations. Has all required tools installed
  
Configuration:
 - All communications between Hashicorp products uses TLS (self-signed certificate authority from `./ca` folder are used)
 - Client certificates are used in communications with Hashicorp services
 - All consul agents are listen on 53 port for DNS

## System requirements

 - VirtualBox (tested on 5.1.22)
 - Vagrant (tested on 1.9.7)
 - vagrant-hostmanager plugin
 - At least 8Gb free memory on workstation

## ToDo

 - End up nomad-vault integration (Certificate SAN issues)
 - Enable Consul ACL
 - Configure Vault's consul secret backend
 - Configure generation Consul agents token through Vault
 - Configure consul-template on nginx load balancer
 - Enable Vault PKI backend
 - Integrate ca with Vault PKI backend
 - Setup dnsmasq for DNS resolution both common domains and *.consul domain
 - Run jenkins on nomad and integrate with
 - Run sample Application

## How-To

Assuming all command blocks are ran from repository root

 - Install vagrant-hostsmanager plugin:
   ```bash
   vagrant plugin install hostmanager
   ```
 - Startup VMs:
   ```bash
   vagrant up
   ```
   *Admin access may be asked several times by vagrant-hostmanager plugin for managing hosts file on the host machine*
 - (**Windows-users only**) Go to UNIX environment
   ```bash
   vagrant ssh devmachine
   ```
 - Setup consul servers:
   ```bash
   cd ./ansible
   ansible-playbook -i inventory/inventory playbooks/install-consul-servers.yaml
   ```
 - Setup Vault servers:
   ```bash
   cd ./ansible
   ansible-playbook -i inventory/inventory playbooks/install-vault.yaml
   ```
 - Setup Consul agents:
   ```bash
   cd ./ansible
   ansible-playbook -i inventory/inventory playbooks/install-consul-agents.yaml
   ```
 - Setup Nomad agents and servers:
   ```bash
   cd ./ansible
   ansible-playbook -i inventory/inventory playbooks/install-nomad.yaml
   ```
 - Setup nginx load balancer:
   ```bash
   cd ./ansible
   ansible-playbook -i inventory/inventory playbooks/deploy-nginxlb-docker-image.yaml
   ```

   After that you will be able to access consul ui on LB via https://nomad.local/consul/ui