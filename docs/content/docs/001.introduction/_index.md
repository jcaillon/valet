---
title: 💡 Introduction
cascade:
  type: docs
weight: 1
url: /docs/introduction
---

## 🤔 What is Valet?

Valet is a tool and a framework that helps you build beautiful CLI/TUI applications in bash.

On its own, Valet comes with:

- A set of core **commands** that can be browsed interactively and executed.
- Several **libraries** that declare bash functions which can be used by commands.

The idea is that Valet can be **extended** by letting the user create its own set of **commands** and **libraries**.

Your custom extensions can then easily be shared and installed by others in a single command.

## ✨ What makes Valet different?

First of all, Valet is a **pure bash**[^1] framework. If you want to write bash script, chances are that you already have bash installed: and that is all you will need.

It works on **any environment with bash** and plays very well with **Git bash for Windows**.

It is written for performance and to minimize the overhead of a script calling your scripts. Contrary to a lot of bash scripts, Valet is as fast on windows (Git bash) as on unix systems!

It is made for providing an awesome user experience in interactive mode, but it is also designed to make your scripts easy to use and debug in CI/CD pipelines; **DevOps engineers should love it**! 💖

{{< cards >}}
  {{< card icon="sparkles" link="../.." title="Showcase" subtitle="Not convinced yet? Check out the feature showcase." >}}
  {{< card icon="arrow-circle-right" link="../installation" title="Install Valet" subtitle="Install Valet and start coding!" >}}
{{< /cards >}}

[^1]: Technically, Valet must rely on external programs _when there is no pure bash solution available_ (e.g. we cannot delete a file in pure bash). But it is designed to be as portable as possible and to work on any environment with bash and coreutils installed.
