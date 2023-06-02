<p align="center">
  <img src="https://user-images.githubusercontent.com/52545545/144147936-39f3e416-8ba0-4f24-915e-f0515f85bb64.png" alt="firezone logo" width="305"/>
</p>
<p align="center">
  <a href="https://github.com/firezone/firezone/releases">
    <img src="https://img.shields.io/github/v/release/firezone/firezone?color=%23999">
  </a>
  <a href="https://discourse.firez.one/?utm_source=readme">
    <img src="https://img.shields.io/static/v1?logo=discourse&logoColor=959DA5&label=support%20forum&labelColor=333a41&message=join&color=611f69" alt="firezone Discourse" />
  </a>
  <img src="https://img.shields.io/static/v1?logo=github&logoColor=959DA5&label=Test&labelColor=333a41&message=passing&color=3AC358" alt="firezone" />
  <a href="https://coveralls.io/github/firezone/firezone?branch=master">
    <img src="https://coveralls.io/repos/github/firezone/firezone/badge.svg?branch=master" alt="Coverage Status" />
  </a>
  <img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/m/firezone/firezone"/>
  <img alt="GitHub closed issues" src="https://img.shields.io/github/issues-closed/firezone/firezone"/>
  <a href="https://cloudsmith.com">
    <img src="https://img.shields.io/badge/OSS%20hosting%20by-cloudsmith-blue?logo=cloudsmith" alt="Cloudsmith">
  </a>
  <a href="https://twitter.com/intent/follow?screen_name=firezonehq">
    <img src="https://img.shields.io/twitter/follow/firezonehq?style=social&logo=twitter" alt="follow on Twitter">
  </a>
</p>

## [Firezone](https://www.firezone.dev/?utm_source=readme) is a self-hosted VPN server and Linux firewall

* Manage remote access through an intuitive web interface and CLI utility.
* [Deploy on your own infrastructure](https://docs.firezone.dev/deploy?utm_source=readme) to keep control of your network traffic.
* Built on [WireGuard®](https://www.wireguard.com/) to be stable, performant, and lightweight.

![Firezone Architecture](https://user-images.githubusercontent.com/52545545/183804397-ae81ca4e-6972-41f9-80d4-b431a077119d.png)

## Get Started

Follow our [deploy guide](https://docs.firezone.dev/deploy) to install your self-hosted instance of Firezone.

Or, if you're on a [supported platform](https://docs.firezone.dev/deploy/docker/supported-platforms?utm_source=readme),
try our [auto-install script](https://docs.firezone.dev/deploy/docker/#option-1-automatic-install).

Using Firezone in production at your organization? Contact us to learn about our [Enterprise Plan](https://www.firezone.dev/contact/sales?utm_source=readme).

## Features

![firezone-usage](https://user-images.githubusercontent.com/52545545/147392573-fe4cb936-a0a8-436f-a69b-c0a9587de58b.gif)

* **Fast:** Uses WireGuard® to be [3-4 times](https://wireguard.com/performance/) faster than OpenVPN.
* **SSO Integration:** Authenticate using any identity provider with an OpenID Connect (OIDC) connector.
* **Containerized:** All dependencies are bundled via Docker.
* **Simple:** Takes minutes to set up. Manage via a simple CLI.
* **Secure:** Runs unprivileged. HTTPS enforced. Encrypted cookies.
* **Firewall included:** Uses Linux [nftables](https://netfilter.org) to block unwanted egress traffic.

### Anti-features

Firezone is **not:**

* An inbound firewall
* A tool for creating mesh networks
* A full-featured router
* An IPSec or OpenVPN server

## Documentation

Additional documentation on general usage, troubleshooting, and configuration can be found at
[https://docs.firezone.dev](https://docs.firezone.dev).

## Get Help

If you're looking for help installing, configuring, or using Firezone, check our
community support options:

1. [Discussion Forums](https://discourse.firez.one/?utm_source=readme): Ask questions, report
  bugs, and suggest features.
1. [Public Slack Group](https://join.slack.com/t/firezone-users/shared_invite/zt-111043zus-j1lP_jP5ohv52FhAayzT6w):
  Join live discussions, meet other users, and get to know the contributors.
1. [Open a PR](https://github.com/firezone/firezone/issues): Contribute a bugfix
  or make a contribution to Firezone.

If you need help deploying or maintaining Firezone for your business, consider
[contacting us about our paid support plan](https://www.firezone.dev/sales?utm_source=readme).

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=firezone/firezone&type=Date)](https://star-history.com/#firezone/firezone&Date)

## Package Repository

[![Hosted By: Cloudsmith](https://img.shields.io/badge/OSS%20hosting%20by-cloudsmith-blue?logo=cloudsmith&style=for-the-badge)](https://cloudsmith.com)

Package repository hosting is graciously provided by  [Cloudsmith](https://cloudsmith.com).
Cloudsmith is the only fully hosted, cloud-native, universal package management solution, that
enables your organization to create, store and share packages in any format, to any place, with total
confidence.

## Developing and Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Security

See [SECURITY.md](SECURITY.md).

## License

See [LICENSE](LICENSE).

WireGuard® is a registered trademark of Jason A. Donenfeld.
