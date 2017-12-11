# Browsercap vvv utility

A Browsercap utility for VVV

This is a repository for [Browser Capabilities Project](http://browscap.org/) utility in [VVV](https://github.com/Varying-Vagrant-Vagrants/VVV).

## Usage

In your `vvv-customy.yml` file add under `utilities`:

```yml
utilities:
  core:
    - memcached-admin
    - opcache-status
    - phpmyadmin
    - webgrind
  browscap:
    - browscap
utility-sources:
  browscap: https://github.com/dingo-d/browscap-vvv-utility
```

The `core` utilities are there by default, and `browscap` doesn't depend on them.

### Versions

* browscap
* browscap-full
* browscap-lite

Once you add it, be sure you re-provision your VVV with `vagrant reload --provision`.
