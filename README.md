# Ansible Collection - nephelaiio.mongodb

[![Build Status](https://github.com/nephelaiio/ansible-collection-mongodb/actions/workflows/molecule.yml/badge.svg)](https://github.com/nephelaiio/ansible-collection-mongodb/actions/wofklows/molecule.yml)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-nephelaiio.mongodb-blue.svg)](https://galaxy.ansible.com/ui/repo/published/nephelaiio/mongodb/)

An [ansible collection](https://galaxy.ansible.com/ui/repo/published/nephelaiio/mongodb/) to install and manage MongoDB clusters

## Collection roles

- nephelaiio.mongodb.repo
- nephelaiio.mongodb.mongos
- nephelaiio.mongodb.mongodb

## Collection playbooks

- nephelaiio.mongodb.install: Install and (re)configure cluster
- nephelaiio.mongodb.offline: Stop mongos cluster services
- nephelaiio.mongodb.online: Start mongos cluster services
- nephelaiio.mongodb.stop: Stop all cluster services
- nephelaiio.mongodb.start: Start all cluster services
- nephelaiio.mongodb.update: Perform cluster-safe os updates

## Testing

Please make sure your environment has [docker](https://www.docker.com) installed in order to run role validation tests.

Role is tested against the following distributions (docker images):

- Ubuntu Noble
- Ubuntu Jammy
- Ubuntu Focal
- Debian Bullseye
- Rocky Linux 9

You can test the collection directly from sources using command `make test`

## License

This project is licensed under the terms of the [MIT License](/LICENSE)
