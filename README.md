# ♣️ Valet

[![Latest Release](https://img.shields.io/github/v/release/jcaillon/valet?sort=date&style=flat&logo=github&logoColor=white&label=Latest%20release&color=%2350C878)][latest-release]
[![Total downloads](https://img.shields.io/github/downloads/jcaillon/valet/total.svg?style=flat)][releases]
[![MIT license](https://img.shields.io/badge/License-MIT-74A5C2.svg?style=flat)][license]
[![bash 5+ required](https://img.shields.io/badge/Requires-bash%20v5+-865FC5.svg?logo=gnubash&logoColor=white)][bash]

[![icon](docs/static/logo.png)][valet-site]

Valet is a framework that helps you build CLI applications in bash.

This tool was initially created to solve the following problem:

> I am building a set of bash scripts to automate various tasks. In each of these scripts, I am writing the same functions to log messages, parse the arguments, display an usage text, handle errors etc... I need generic functions that do these jobs for me, and which I can source in each of my scripts.

Once this basic requirement was fulfilled, more and more features were added **to make writing code in bash somewhat enjoyable**.

With Valet, you can setup and execute tests for your scripts, code an interactive experience for your users, navigate and execute your scripts (called *commands*) from a searchable menu interface. It **provides libraries of functions that can be source'd** to solve standard programming needs such as string, array or file manipulation, and so on...

Learn more on the [Valet documentation website][valet-site].

Installation instructions can be found [here][installationLink].

[releases]: https://github.com/jcaillon/valet/releases
[latest-release]: https://github.com/jcaillon/valet/releases/latest
[license]: ./LICENSE
[bash]: https://www.gnu.org/software/bash/
[valet-site]: https://jcaillon.github.io/valet/
[installationLink]: https://jcaillon.github.io/valet/docs/installation/
