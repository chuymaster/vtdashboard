**[THIS PROJECT IS NOT MAINTAINED ANYMORE]**

# vtdashboard

A back-office iOS application for managing channel registration for [Thai VTuber Ranking website](https://vtuber.chuysan.com/#/), made with SwiftUI.

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

## Target

- Xcode 13.3.1, iOS 15+

## Features

- Pure SwiftUI application with fully working Previews.
- GET and POST with REST API, with authorization header at [NetworkClient](https://github.com/chuymaster/vtdashboard/blob/main/VtDashboard/Infrastructures/NetworkClient.swift)
- Authorize with firebase at [AuthenticationClient](https://github.com/chuymaster/vtdashboard/blob/main/VtDashboard/Infrastructures/AuthenticationClient.swift)
- Persist server environment locally with `@AppStorage`
- Sample `Combine` test case at [ChannelRequestsViewModelTests](https://github.com/chuymaster/vtdashboard/blob/main/VtDashboard/Application/ChannelRequests/ChannelRequestsViewModelTests.swift)

## Screenshot

- Channel registration request management

| Request List                                                                                                                                                            | Action Sheet                                                                                                                                                            | Sign In                                                                                                                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![Simulator Screen Shot - iPhone 13 Pro - 2022-05-15 at 19 20 37](https://user-images.githubusercontent.com/8290104/168468924-e3d324f2-e167-4e4e-97a5-cedd3f71d321.png) | ![Simulator Screen Shot - iPhone 13 Pro - 2022-05-15 at 19 20 41](https://user-images.githubusercontent.com/8290104/168468935-96484f29-b9e8-44c3-9077-fb3b92288150.png) | ![Simulator Screen Shot - iPhone 13 Pro - 2022-05-15 at 19 50 41](https://user-images.githubusercontent.com/8290104/168469109-34a1daef-c120-4052-a2dc-2ef3d470fae8.png) |

- A screenshot demonstrating the registration of requested channel to list on [Thai VTuber Ranking site](https://vtuber.chuysan.com/#/)

<img src="https://user-images.githubusercontent.com/8290104/168468937-ddec52a5-5cb4-4e46-9b70-ad9cdcf87de0.gif" width=300 />

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
