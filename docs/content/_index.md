---
title: Valet
layout: hextra-home
keywords:
  - bash
  - script
  - windows
  - interactive
  - menu
  - search
  - string
---

<div class="hx-mt-6 hx-mb-6">
{{< hextra/hero-headline >}}
  Valet
{{< /hextra/hero-headline >}}
</div>

<div class="hx-mb-12">
{{< hextra/hero-subtitle >}}
  Valet is a zero dependency framework that helps you build fast, robust, testable and interactive bash scripts.
{{< /hextra/hero-subtitle >}}
</div>

<img id="logo1" src="logo.png" alt="logo" height="3rem" width="auto" />
<img id="logo1-dark" src="logo-dark.png" alt="logo" height="3rem" width="auto" />
<script>
if (document.documentElement.style.colorScheme === "dark") {
  document.getElementById("logo1").style.display = "none";
  document.getElementById("logo1-dark").style.display = "block";
} else {
  document.getElementById("logo1").style.display = "block";
  document.getElementById("logo1-dark").style.display = "none";
}
</script>

<div class="hx-mb-6" style="padding-top: 2rem; padding-bottom: 2rem;">
{{< hextra/hero-button text="Read the docs" link="docs" >}}
</div>
{{< hextra/feature-grid >}}
  {{< hextra/feature-card
    link="showcase"
    icon="shield-check"
    title="Build professional CLI tools"
    subtitle="Valet gives you the framework and functions required to **build awesome tools, effortlessly**, in bash. Get everything you expect from a good CLI software (e.g. git, docker...) in a few lines of bash code."
    class="hx-aspect-auto md:hx-aspect-[1.1/1] max-md:hx-min-h-[340px]"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(21,19,110,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="showcase"
    icon="terminal"
    title="Turn your scripts into commands"
    subtitle="Valet enables you to easily create **commands** that can take arguments and/or options automatically parsed by the framework. Exceptions are gracefully handled with the error stack printed to the user."
    class="hx-aspect-auto md:hx-aspect-[1.1/1] max-md:hx-min-h-[340px]"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(221,210,59,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="showcase"
    icon="cursor-click"
    title="Interactively execute your commands"
    subtitle="Find all your commands in a convenient menu with fuzzy finding capabilities. Get prompted for missing arguments or options to make your commands easy to use."
    class="hx-aspect-auto md:hx-aspect-[1.1/1] max-md:hx-min-h-[340px]"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(194,97,254,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="showcase"
    icon="puzzle"
    title="Libraries of pure bash functions"
    subtitle="Make your scripts more performant and write code faster by using Valet libraries for string manipulation, interactive prompt, pure bash I/O and more..."
    class="hx-aspect-auto md:hx-aspect-[1.1/1] max-lg:hx-min-h-[340px]"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(38,116,56,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="showcase"
    icon="beaker"
    title="Test your commands"
    subtitle="Ever wondered how you can effectively setup unit tests for your scripts? Valet standardizes the way you test functions and commands with approval tests approach. Run them all in a single command and automate tests in CI pipelines."
    class="hx-aspect-auto md:hx-aspect-[1.1/1] max-md:hx-min-h-[340px]"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(0,98,98,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="showcase"
    icon="book-open"
    title="Clear and standardized help"
    subtitle="Declare properties for your commands which are used to automatically display a user friendly documentation."
    class="hx-aspect-auto md:hx-aspect-[1.1/1] max-lg:hx-min-h-[340px]"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(142,53,74,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    link="showcase"
    icon="play"
    title="Made for CI/CD automation"
    subtitle="Valet only requires bash, has advanced logging capabilities and can be entirely configured through environment variables, which makes it a great candidate as a core framework to build your CI/CD jobs."
    class="hx-aspect-auto md:hx-aspect-[1.1/1] max-md:hx-min-h-[340px]"
  >}}
  {{< hextra/feature-card
    link="showcase"
    icon="cube-transparent"
    title="Pure bash, zero dependencies"
    subtitle="Simply run the install script which copies Valet and you are good to go, you will only ever need bash!"
    class="hx-aspect-auto md:hx-aspect-[1.1/1] max-md:hx-min-h-[340px]"
  >}}
  {{< hextra/feature-card
    link="showcase"
    icon="lightning-bolt"
    title="Lighting fast on any platform"
    subtitle="Valet does not use forking which makes it super fast, even on windows Git bash."
    class="hx-aspect-auto md:hx-aspect-[1.1/1] max-md:hx-min-h-[340px]"
  >}}
{{< /hextra/feature-grid >}}
