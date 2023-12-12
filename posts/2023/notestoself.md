# Some notes to my self
I recently set up a server to host a little site for some friends of mine. It's not something I do too often, so I realized I should make some notes about everything I did so I don't have to have a dozen tabs of tutorials open the next time I do it.

## Server
I don't feel like bothering with a home server, so I just spun up a vps. This time it was on Vultr, but there's plenty of providers to choose from.

Create the VM. Debian, because that's what I know, and it has plenty of documentation for what I don't. Log in as root, and let's get started.

Root is risky, so create a non root user. `adduser` is the command you want, not `useradd`. We are going to give this account sudo priveleges so it can do administrative things.

That will look like `# adduser admin_user -G sudo`

## SSH
The first thing is to get access to the server configured securely. *Step one* is to send my public key over with `ssh-copy-id`. Next edit `/etc/ssh/sshd_config` and disable password authentication. While we're at it, change the port number. It's less important since if someone wants to get in, they can find the ssh port anyway, but it will at least shake off the bots that will constantly be hitting it anyway. *Write this port down somewhere.*

On the client side, it will be convenient to set up your ssh config to know about this. Add this to `~/.ssh/config`:
```
Host $server_domain
   Port $port_number 
```
This way you won't have to remember to type it in for ssh and scp. Which is especially nice because they have *different* flags for specifying the port number, -p and -P respectively.
## Firewall
Set up a firewall. [ufw is a handy tool for this.](https://wiki.archlinux.org/title/Uncomplicated_Firewall) Allow the ssh port, http(s), and whatever other ports the stuff you're running needs. Deny everything else.

## Webserver
At some point I'll try Apache, for now I use Nginx. Install that through your package manager.
