Ansible Role:Red Hat Application Migration Toolkit on OpenShift
=========

This role for deploying RHAMT Web console with integrating RH-SSO on OpenShift.

Role Variables
------------

| Variable                    | Default Value      | Required |  Description   |
|-----------------------------|--------------------|----------|----------------|
|`OCP_PROJECT`                | `rhamt`            | Required | OpenShift project name to provision this role |
|`RHAMT_VOLUME_CAPACITY`      | `10Gi`             | Optional | Persistance volume capacity of RHAMT Pod |
|`REQUESTED_CPU`              | `1`                | Optional | Requested CPU resources of RHAMT Pod |
|`REQUESTED_MEMORY`           | `2Gi`              | Optional | Requested MEMORY resources of RHAMT Pod |
|`DB_DATABASE`                | `WindupServicesDS` | Optional | PostgreSQL Database name |
|`DB_USERNAME`                | `postgresuser`     | Optional | PostgreSQL Database username |
|`DB_PASSWORD`                | `postgrespassword` | Optional | PostgreSQL Database password |
|`APP`                        | `rhamt-web-console`| Optional | RHAMT Pod's application name |
|`APP_DIR`                    | `app`              | Optional | RHAMT Pod's application directory path |
|`DOCKER_IMAGES_TAG`          | `4.2.1.Final`      | Optional | RHAMT container image tag in Quay.io |

OpenShift Version Compatibility
------------

When listing this role in `requirements.yml`, make sure to pin the version of the role via one of the tags:

```
- src: danieloh30.rhamt
  version: 1.2.0
```  

The following tables shows the version combinations that are tested and verified:

| Role Version      | OpenShift Version |
|-------------------|-------------------|
| 1.2.0   | 3.11.x  |

Note that if a version combination is not listed above, it does **NOT** mean that it won't work on that 
version. The above table is merely the combinations that we have verified and tested.


Example Playbook
------------

```
name: Example Playbook
hosts: localhost
tasks:
- import_role:
    name: danieloh30.rhamt
  vars:
    OCP_PROJECT: "rhamt"
```

Test locally
------------
If you want to test this role locally:

```
ansible-playbook -i tests/inventory tests/role_provision.yml \
        -e OCP_PROJECT=rhamt
```

__NOTE:__ Add as many parameter variations from the defaults as you want

If you want to delete all RH-SSO users like userxx locally:
```
ansible-playbook -i tests/inventory tests/rhsso_delete_users.yml \
        -e OCP_PROJECT=rhamt
```