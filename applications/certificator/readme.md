# Certificator

Certificator is a CLI application that is part of the Application Manager package. It is designed to manage and create SSL certificates and Nginx site servers.

## Introduction

Certificator simplifies the process of setting up SSL certificates for specified domains using Certbot and configuring Nginx to use these certificates. It provides a set of commands to add, delete, and list SSL certificates and their associated domains.

> **Warning**: Certbot has a rate limit on the number of SSL certificates you can issue per week for a single domain or subdomain. Currently, you can issue a maximum of 5 new certificates per week. Please plan your certificate management accordingly.

## Usage

To use Certificator, you need to call it with the `certificator` command and the necessary arguments. The available commands are:

- `add`: This command is used to add an SSL certificate for a specified domain and configure Nginx to use it. It requires two arguments: the domain for which to obtain the SSL certificate and the proxy_pass URL which the domain will be pointed at. For example:

```bash
certificator add example.com http://localhost:3000
```

- `del`: This command is used to delete the SSL certificate for a specified domain and remove the Nginx configuration. It requires one argument: the domain for which to delete the SSL certificate, you can choose whether to delete the certification or keep it during the deleting process, if you choose to keep it, then the `add` command for the same domain will reuse the same certification without making a new one. For example:

```bash
certificator del example.com
```

- `ls`: This command is used to list all SSL certificates and their associated domains from the Nginx sites config. It does not require any arguments. For example:

```bash
certificator ls
```
