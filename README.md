# vtdashboard

## Setup

This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) to generate the project file. The generation command is run via `Mint`

- Install [Mint](https://github.com/yonaskolb/mint)

```
brew install mint
```

- Run `make` to build the project


## Tips command

- Remove files created before `.gitignore`

```
git rm --cached `git ls-files -i --exclude-from=.gitignore`
```