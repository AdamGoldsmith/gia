# Get Into Ansible

![alt text](images/Ansible.png "Ansible Logo")


Tutorial for getting started with Ansible

## What is Ansible

Loads of docs on this, but in its simplest form, it is a configuration management tool

## Installing the Ansible Controller

The Ansible controller (where all the commands are run from) must be installed on a Linux-based machine. We will install into a python virtual environment to keep things isolated.

> _**Note**: For Windows users, Ansible can be installed in [WSL (Windows Subsystem for Linux)](https://learn.microsoft.com/en-us/windows/wsl/install)_

![alt text](images/Bash.png "Bash Logo")

1. Install python virtual environment software
    ```shell
    sudo apt install python3.10-venv
    ```
1. Create venvs directory
    ```shell
    mkdir ~/venvs
    ```
1. Create a virtual enviornment called `ansible`
    ```shell
    python3 -m venv ~/venvs/ansible
    ```
1. Source the newly-created virtual environment
    ```shell
    source ~/venvs/ansible/bin/activate
    ```
1. Upgrade the pip package installer
    ```shell
    pip install pip --upgrade
    ```
1. Populate `requirements.txt` (or use repo-supplied file)
    ```shell
    echo "ansible
    ansible-lint
    molecule
    netaddr
    pyaml" > ~/venvs/requirements.txt
    ```
1. Install Ansible pip packages into the environment
    ```shell
    pip install -r ~/venvs/requirements.txt
    ```

## Our Ansible Configuration

![alt text](images/LXD.png "LXC Logo")

## Ansible concepts

* Targets
* Inventories
* Adhoc commands
* Playbooks
* Facts
* Configuration settings
* Vault

