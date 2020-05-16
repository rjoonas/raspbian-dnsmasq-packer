<img src="https://upload.wikimedia.org/wikipedia/commons/2/2c/Dnsmasq_icon.svg" align="right" width="200" />

# raspbian-dnsmasq-packer

Packer template to build a simple Raspberry Pi DNS server running [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html). Base OS is Raspbian Lite.

Features:

* dnsmasq with decent defaults
* Preconfigured SSH key login, password auth is disabled
* dnsutils installed for local debugging
* Uses arm-image Packer builder, can be built on non-ARM architectures.

## Building with Docker + packer-builder-arm-image

Prerequisites: Docker is running, you have a SSH public key at `~/.ssh/id_rsa.pub`.

1. Clone [solo-io/packer-builder-arm-image](https://github.com/solo-io/packer-builder-arm-image) and run `docker build -t packer-builder-arm .` there to get the image locally
2. Run `./build.sh` in this repo. It will mount `~/.ssh/id_rsa.pub` from your local filesystem inside Docker and configure it in the built image.
3. Flash `output-arm-image/image` to a MicroSD card and boot your Pi.
4. ssh in as user `pi`, edit `/etc/hosts` to add local DNS records.

### Known issues

kpartx sometimes fails with the following error message. It's a race condition somewhere, just try again and it will work.

```
==> arm-image: error kaprts -l exit status 1: mount: could not find any device /dev/loop#Bad address
==> arm-image: can't set up loop
==> arm-image:
Build 'arm-image' errored: step canceled or halted
```

## Ideas for further development

* Firewall config
* DNS-over-TLS with stubby + 9.9.9.9
