# vtdashboard

A back-office application for channel registration of https://vtuber.chuysan.com/#/

## Setup

This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) to generate the project file. The generation command is run via `Mint`

- Install [Mint](https://github.com/yonaskolb/mint)

```
brew install mint
```

- Install [Bundler](https://bundler.io/)

```
gem install bundler
```

- Run `make setup` to setup the project
- Open `VtDashboard.xcodeproj` and happy coding!

# Development

## Xcodegen

Run `make xcodegen` when you add new files or pulling new files from the repository.

## UserDefaults

Keys and values of UserDefaults are defined in `UserDefaultsKey` enum.

## Tips command

- Remove files created before `.gitignore`

```
git rm --cached `git ls-files -i --exclude-from=.gitignore`
```
