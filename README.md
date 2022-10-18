# Get Into Ansible

Tutorial for getting started with Ansible

[Google Slides Presentation](https://docs.google.com/presentation/d/1fnMS3VxOudrA15qwDTQke1pFauohJyUHyLjIuDcitpE/edit?usp=sharing)

## Ansible background

![alt text](images/Ansible.png "Ansible Logo")

### What is Ansible?

Loads of docs on this, but in its simplest form, it is a configuration management tool written in python by Michael DeHaan in 2012.

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

LXC Container     | Image                      | Purpose
------------------|----------------------------|--------
GIA (host)        | n/a                        | Ansible Controller
ansible-target-01 | ubuntu:22.04               | Ansible Target
ansible-target-02 | ubuntu:22.04               | Ansible Target
ansible-target-03 | images:almalinux/8/cloud   | Ansible Target
ansible-target-04 | images:opensuse/15.4/cloud | Ansible Target

## Ansible concepts

* Targets
* Inventories
* Adhoc commands
* Playbooks
* Facts
* Configuration settings
* Ansible Vault

## Tutorials

![alt text](images/Bash.png "Bash Logo")

### Installing the Ansible Controller

The Ansible controller (where all the commands are run from) must be installed on a Linux-based machine. We will install into a python virtual environment to keep things isolated.

> _**Note**: For Windows users, Ansible can be installed in [WSL (Windows Subsystem for Linux)](https://learn.microsoft.com/en-us/windows/wsl/install)_

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
1. Populate `requirements.txt` (or use [repo-supplied file](requirements.txt) for pinned versions)
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
    ```
