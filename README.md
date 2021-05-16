<div align="center">
  <h1>Amber Helper</h1>
  <p>Bring the Unix philosophy to the browser.</p>
  <a href="https://github.com/paysonwallach/amber-helper/releases/latest">
    <img alt="Version 0.1.0" src="https://img.shields.io/badge/version-0.1.0-red.svg?cacheSeconds=2592000&style=flat-square" />
  </a>
  <a href="https://github.com/paysonwallach/amber-helper/blob/master/LICENSE" target="\_blank">
    <img alt="Licensed under the GNU General Public License v3.0" src="https://img.shields.io/github/license/paysonwallach/amber-helper?style=flat-square" />
  <a href=https://buymeacoffee.com/paysonwallach>
    <img src=https://img.shields.io/badge/donate-Buy%20me%20a%20coffe-yellow?style=flat-square>
  </a>
  <br>
  <br>
</div>

## Background

[Amber](https://github.com/paysonwallach/amber-web-extension#readme) is a browser extension that enables sessions to be saved as portable, human-readable, and editable files. [Amber Helper](https://github.com/paysonwallach/amber-helper) is the host application that provides OS-level integration and support for opening session files.

## Installation

Clone this repository or download the [latest release](https://github.com/paysonwallach/amber-helper/releases/latest).

```shell
git clone https://github.com/paysonwallach/amber-helper
```

Configure the build directory at the root of the project.

```shell
meson --prefix=/usr build
```

Install with `ninja`.

```shell
ninja -C build install
```

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change. By participating in this project, you agree to abide by the terms of the [Code of Conduct](https://github.com/paysonwallach/amber-helper/blob/master/CODE_OF_CONDUCT.md).

## License

[Amber Helper](https://github.com/paysonwallach/amber-helper) is licensed under the [GNU General Public License v3.0](https://github.com/paysonwallach/amber-helper/blob/master/LICENSE).
