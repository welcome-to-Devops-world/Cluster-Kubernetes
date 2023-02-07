# Configure Highly Available HAProxy with Keepalived on Ubuntu 20.04
While Keepalived uses Linux virtual server (LVS) to perform load balancing and failover tasks on the active and passive routers, HAProxy performs load balancing and high-availability services to TCP and HTTP applications.

Keepalived utilizes Virtual Router Redundancy Protocol to send periodic advertisements between the master (active) and backup (passive) LVS routers (which in our case is the HAProxy servers since are load balancing web apps) to determine the state of each other. If a master server fails to advertise itself within a predefined period of time, Keepalived initiates failover and the backup server becomes the master.

All virtual servers are assigned a Virtual IP, also known as floating IP. This is a publicly routable IP/address. It is assigned dynamically to an active server at any given time.
Configure Highly Available HAProxy with Keepalived on Ubuntu 20.04

This setup requires that you already have an HAProxy server setup and running. We have covered the installation and setup of HAProxy load balancer on various systems in our previous guides;
In this tutorial, we will be using two HAProxy servers with Keepalived for high availability. Below is our deployment architecture.
Assuming that you already have HAProxy setup, proceed with installation and configuration of Keepalived on Ubuntu 20.04.

HAproxy is an open-source and lightweight package that offers high availability and load balancing for TCP and HTTP based programs. It distributes the load among the web and application servers. HAproxy is available for nearly all Linux distributions. It is a widely used load balancer that is popular for its efficiency, reliability, and low memory and CPU footprint. In this post, we will explain how to install and configure HAproxy on a Ubuntu system.


- Note: The procedure and commands mentioned in this post has been tested on Ubuntu 20.04 LTS (Focal Fossa). The same procedure is also valid for Debian and Mint distributions.
## Network Details

We will be using three Ubuntu servers; all on the same network. The details of our servers are as follows:

```
1.1.1.111 haproxy01-k8s-cluster.Domain.local haproxy01
1.1.1.112 haproxy02-k8s-cluster.Domain.local haproxy02
1.1.1.115 virtualip-k8s-cluster.Domain.local virtualip
```
- Note: You must have sudo privileges on all the servers.

We will configure one machine as a load balancer and the other two as web servers. The HAproxy server will be our front-end server that will receive the requests from the users and forward them to the two web servers. The web servers will be our Backend servers that will receive those forwarded requests.

## Installing HAproxy load balancer

Now in this step, we will be installing the HAproxy on one of our Ubuntu server (1.1.1.111 and 1.1.1.112). To do so, update apt using the following command in Terminal:
```
$ sudo apt-get update
```
Then update packages using the below command:
```
$ sudo apt-get upgrade
```
Now install HAproxy using the following command in Terminal:
```
$ sudo sudo apt install haproxy
```
Once the installation of the HAproxy server is finished, you can confirm it using the below command in Terminal:
```
$ haproxy -v
```
It will show you the installed version of HAproxy on your system which verifies that the HAproxy has been successfully installed.

## Configuring HAproxy as a load balancer

In the following section, we will configure HAproxy as a load balancer. To do so, edit the /etc/haproxy/haproxy.cfg file:
$ sudo nano <strong>/etc/haproxy/haproxy.cfg</strong>


The above configuration enables the HAproxy “stats” page using the stats directive and secures it with http basic authentication using the username and password defined by the stats auth directive.

Once you are done with the configurations, save and close the haproxy.cfg file.

Now verify the configuration file using the below command in Terminal:
```
$ haproxy -c -f /etc/haproxy/haproxy.cfg
```
The following output shows that the configurations are correct.

Now to apply the configurations, restart the HAproxy service:
```
$ sudo systemctl restart haproxy.service
```
It will stop and then start the HAproxy service.

To check the status of the HAproxy service, the command would be:
```
$ sudo systemctl status haproxy.service
```
The active (running) status in the following output shows that the HAproxy server is enabled and running fine.

Here are some other commands for managing the HAproxy server:

In order to start the HAproxy server, the command would be:
```
$ sudo systemctl start haproxy.service
```
In order to stop the HAproxy server, the command would be:
```
$ sudo systemctl stop haproxy.service
```
In case you want to temporarily disable the HAproxy server, the command would be:
```
$ sudo systemctl disable haproxy.service
```
To re-enable the HAproxy server, the command would be:
```
$ sudo systemctl enable haproxy.service
```

## Testing HAproxy Monitoring

To access the HAproxy monitoring page, type http:// followed by the IP address/hostname of HAproxy server and port 8081/stats:
http://1.1.1.115:8081/stats
```
user: admin ,pass: 123
```
The following authentication box will appear. Enter the username and password you have configured earlier in the configurations and then press OK.

This is the statistics report for our HAproxy server.

There you have the installation and configuration of HAproxy load balancer on the Linux system. We have just discussed the basic setup and configuration of HAproxy as a load balancer for Apache web servers. We also looked at some commands for managing the HAproxy server. In the end, we tested the load balancing through the browser and the curl command.


## Install Keepalived on Ubuntu 20.04

In our demo environment, we are running HAProxy servers on Ubuntu 20.04. Therefore, assuming your system package cache is up-to-date, run the command below install Keepalived on Ubuntu 20.04
```
# apt install keepalived
```
Similarly, install Keepalived on second HAProxy server.
```
# apt install keepalived
```
Configure IP forwarding and non-local binding

To enable Keepalived service to forward network packets to the backend servers, you need to enable IP forwarding. Run this command on both HAProxy servers;
```
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
```
Similarly, you need to enable HAProxy and Keepalived to bind to non-local IP address, that is to bind to the failover IP address (Floating IP).
```
echo "net.ipv4.ip_nonlocal_bind = 1" >> /etc/sysctl.conf
```
Reload sysctl settings;
```
sysctl -p
```
Configure Keepalived

The default configuration file for Keepalived should be /etc/keepalived/keepalived.conf. However, this configuration is not created by default. Create the configuration with the content below;
```
vim /etc/keepalived/keepalived.conf
```
Running Keepalived on Ubuntu 20.04

You can now start and enable Keepalived to run on system boot on all nodes;
```
systemctl enable --now keepalived
```
Check the status on Master Node;
```
systemctl status keepalived
```
You can as well check the status on the slave node.

Check the IP address assigment;

On the master node;
```
root@haproxy01-k8s-cluster:~# ip --brief add
lo               UNKNOWN        127.0.0.1/8 ::1/128
ens160           UP             1.1.1.111/23 1.1.1.115/32 fe80::250:56ff:fe89:86a/64
```