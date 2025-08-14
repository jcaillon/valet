# Valet documentation

**IMPORTANT LINKS:**

- [Live documentation link][live-url].
- [Hugo documentation][hugo-docs].
- [Hextra documentation][hextra].
- [Markdown guide][markdown-guide].
- [Markdown cheatsheet][cheatsheet].
- [Heroic Icons][heroic-icons].

This documentation is generated using [Hugo][hugo] with the [Hextra][hextra] theme.

---

[[_TOC_]]

---

## How to contribute

### Prerequisites

You need to download and install:

- Hugo extended ([download][download-hugo])  
  Make sure you download the _extended version_ of Hugo which supports SCSS.  
  Version used: Hugo extended 0.124.1.
- GO ([download][download-go])

You should also quickly check the official [Hextra documentation][hextra-docs]. It can be read in 5 minutes and give you all the keys you need to efficiently work on this documentation.

### Run

Clone this repository locally.

Run the Hugo server (you need to run this command in the directory of the docs):

```bash
hugo server --disableFastRender --watch
```

You will be able to reach your local version of the documentation at <http://localhost:1313/> and see your modifications applied in live.

### Work on the documentation

It is recommended to install and work with [vscode](https://code.visualstudio.com/). 

You will find recommended extensions for this project using the filter `@recommended` in vscode extensions marketplace.

### Generate the section navigation

To generate the section navigation, you can use the following command:

```bash
./generate-section-navigation.sh
```

It will generate the file `layouts/shortcodes/main-section-end.html` which can then be included in each section page.

## Update the theme

To update the theme to the latest Hextra version, run:

```bash
hugo mod get -u
```

[live-url]: https://jcaillon.github.io/valet/
[hugo]: https://gohugo.io
[hugo-docs]: https://gohugo.io/documentation
[hextra]: https://imfing.github.io/hextra/
[download-go]: https://go.dev/dl/
[download-hugo]: https://github.com/gohugoio/hugo/releases
[markdown-guide]: https://www.markdownguide.org/
[heroic-icons]: https://v1.heroicons.com/
[cheatsheet]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
[hextra-docs]: https://imfing.github.io/hextra/docs/guide/
