---
title: 💡 Introduction
cascade:
  type: docs
weight: 1
url: /docs/introduction
---

## 🤔 What is Valet?

Valet is a framework that helps you build CLI applications in bash.

This tool was initially created to resolve the following problem:

> I am building a set of bash scripts to automate various tasks. In each of these scripts, I am writing the same functions to log messages, parse the arguments, display an usage text, handle errors etc... I need generic functions that do these jobs for me, and which I can source in each of my scripts.

Once this basic requirement was fulfilled, more and more features were added **to make writing code in bash somewhat enjoyable** (I may have an issue with weakly typed languages 😅).

With Valet, you can setup and execute tests for your scripts, code an interactive experience for your users, navigate and execute your scripts (called *commands*) from a searchable menu interface. It **provides libraries of functions that can be source'd** to solve standard programming needs such as string, array or file manipulation, and so on...

## ✨ What makes Valet different?

First of all, Valet is a **pure bash** framework. If you want to write bash script, chances are that you already have bash installed: and that is all you will need.

It works on **any Linux environment with bash** or on **Git bash for Windows**.

It is written for performance and to minimize the overhead of a script calling your scripts. Contrary to a lot of bash scripts, Valet is as fast on windows (Git bash) as on Linux!

It is made for providing an awesome user experience in interactive mode, but it is also designed to make your scripts easy to use and debug in CI/CD pipelines; **DevOps engineers should love it**! 💖

{{< cards >}}
  {{< card icon="sparkles" link="../../showcase" title="Showcase" subtitle="Not convinced yet? Check out the feature showcase." >}}
  {{< card icon="arrow-circle-right" link="../installation" title="Install Valet" subtitle="Install Valet and start coding!" >}}
{{< /cards >}}
