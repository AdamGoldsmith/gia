# Get Into Ansible

Tutorial for getting started with Ansible

## Ansible background

![alt text](images/Ansible.png "Ansible Logo")

### What is Ansible?

Loads of docs on this, but in its simplest form, it is a configuration management tool written in python.

### Why use Ansible?

* Standard
* Reliable
* Supported
* Repeatable
* Idempotent
* Secure
* Infrastructure as Code
* Cross-system
* Low barrier to entry
* Auditable

> _**Note**: Ask yourself if you can apply Ansible on any new project/idea_

### How do you use Ansible?

Ansible controller executes tasks simultaneously to multiple, targeted hosts, usually via SSH. Only changes to state will be applied owing to Ansible's idempotent nature.

## Our Ansible Configuration

![alt text](images/LXD.png "LXC Logo")

We will be using LXC/LXD, which is a lightweight container/VM orchestration tool, for our Ansible tutorial environment

LXC Container | Image                        | Purpose
--------------|------------------------------|--------
GIA (host)    | Ubuntu 22.04                 | Ansible Controller
lion          | ubuntu:22.04                 | Ansible Target
tiger         | images:debian/bookworm/cloud | Ansible Target
shark         | images:alpine/3.16/cloud     | Ansible Target

## Installing the Ansible Controller

The Ansible controller (where all the commands are run from) must be installed on a Linux-based machine. We will install into a python virtual environment to keep things isolated.

> _**Note**: For Windows users, Ansible can be installed in [WSL (Windows Subsystem for Linux)](https://learn.microsoft.com/en-us/windows/wsl/install)_

![alt text](images/Bash.png "Bash Logo")

1. Install python virtual environment software
    ```bash
    sudo apt install python3-venv
    ```
1. Create venvs directory
    ```bash
    mkdir ~/venvs
    ```
1. Create a virtual enviornment called `ansible`
    ```bash
    python3 -m venv ~/venvs/ansible
    ```
1. Source the newly-created virtual environment
    ```bash
    source ~/venvs/ansible/bin/activate
    ```
1. Upgrade the pip package installer
    ```bash
    pip install pip --upgrade
    ```
1. Populate `requirements.txt` (or use repo-supplied file)
    ```bash
    echo "ansible
    ansible-lint
    molecule
    netaddr
    pyaml" > ~/venvs/requirements.txt
    ```
1. Install Ansible pip packages into the environment
    ```bash
    pip install -r ~/venvs/requirements.txt
    ```
1. Test Ansible installation
    ```bash
    ansible --version
    ansible localhost -m ping
    ```

## Ansible concepts

* Targets
* Inventories
* Adhoc commands
* Playbooks
* Facts
* Configuration settings
* Ansible Vault

## Tutorial

We will first use Ansible adhoc commands to create SSH key pairs locally on the Ansible Controller. These will be used to authenticate connections to the Ansible target hosts.

> _**Note**: Ideally these SSH key pairs would be baked into the newly-created LXC containers using something like cloud-init_

1. Login to the Ansible LXC container
    ```bash
    lxc exec ansible bash
    ```
1. Source the ansible virtual environment
    ```bash
    source ~/venvs/ansible/bin/activate
    ```
1. Create a local SSH key directory
    ```bash
    ansible localhost -m ansible.builtin.file -a "path=ssh_keys state=directory"
    ```
1. Create a local SSH key pair
    ```bash
    ansible localhost -m community.crypto.openssh_keypair -a "path=ssh_keys/id_ansible type=ed25519"
    ```
1. Display the public key
    ```bash
    cat ssh_keys/id_ansible.pub
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqLnVWATu4sF+IoXElAbAX8Pk85ioxnloDdrUjN7YJ0
    ```
1. Login to each of the Ansible target hosts (lion, tiger, shark)
    ```bash
    lxc exec lion bash
    ```
1. Create and configure an Ansible user
    ```bash
    useradd -c 'Ansible user' -m ansible
    mkdir /home/ansible/.ssh
    chown ansible.ansible /home/ansible/.ssh
    chmod 0700 /home/ansible/.ssh
    echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqLnVWATu4sF+IoXElAbAX8Pk85ioxnloDdrUjN7YJ0" > /home/ansible/.ssh/authorized_keys
    chown ansible.ansible /home/ansible/.ssh/authorized_keys
    chmod 0600 /home/ansible/.ssh/authorized_keys
    ```
1. Exit the target LXC container
    ```bash
    exit
    ```

