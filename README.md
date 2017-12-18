![](https://i.imgur.com/OWfQe0m.png)

# Frisbee
Another simple network wrapper for URLSession. Built to be small and easy to create tests at the network layer of your application.

[![Build Status](https://www.bitrise.io/app/27a5e39dc511ba7c/status.svg?token=HZCmnpdBTIy3rOQdUv6HOg&branch=master)](https://www.bitrise.io/app/27a5e39dc511ba7c) [![CocoaPods](https://img.shields.io/cocoapods/v/Frisbee.svg)]() [![CocoaPods](https://img.shields.io/cocoapods/p/Frisbee.svg)]() [![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)]() [![codecov](https://codecov.io/gh/ronanrodrigo/frisbee/branch/master/graph/badge.svg)](https://codecov.io/gh/ronanrodrigo/frisbee)

## Install
### Carthage
To integrate Frisbee into your Xcode project using Carthage, specify it in your Cartfile:

```
github "ronanrodrigo/Frisbee"
```

Run carthage update to build the framework and drag the built Frisbee.framework into your Xcode project.

### CocoaPods
To integrate Frisbee into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Frisbee'
end
```

Then, run the following command:

```bash
$ pod install
```

### Swift Package Manager
To integrate Frisbee into your Swift Package Manager project, set the dependencies in your `Package.swift`:

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "<Your Packege Name>",
    dependencies: [
        .package(url: "https://github.com/ronanrodrigo/Frisbee.git", from: "0.0.23")
    ],
    targets: [
        .target(name: "<Your Packege Name>", dependencies: ["Frisbee"])
    ]
)
```

## Usage

### Create a decodable entity
```swift
struct Movie: Decodable {
    let name: String
}
```

### This is an example of some code that will request some data across network.
```swift
class MoviesController {
    private let getRequest: FBEGetable
    var moviesQuantity = 0

    // Expect something that conforms to FBEGetable
    init(getRequest: FBEGetable) {
        self.getRequest = getRequest
    }

    func didTouchAtListMovies() {
        getRequest.get(url: "http://www.com.br/movies.json") { (moviesResult: FBEResult<[Movie]>) in
            switch moviesResult {
                case let .success(movies): self.moviesQuantity = movies.count
                case let .fail(error): print(error)
            }
        }
    }
}

```

##### In production-ready code you must inject an instance of `FBENetworkGet`.
```swift
// Who will call the MoviesController must inject a FBENetworkGet instance
MoviesController(getRequest: FBENetworkGet())
```

# Usage in tests

##### In test target code you can create your own `FBEGetable` mock.
```swift
public class FBEMockGet: FBEGetable {
    var decodableMock: Decodable!

    public func get<Entity: Decodable>(url: URL, completionHandler: @escaping (FBEResult<Entity>) -> Void) {
        get(url: url.absoluteString, completionHandler: completionHandler)
    }

    public func get<Entity: Decodable>(url: String, completionHandler: @escaping (FBEResult<Entity>) -> Void) {
        if let decodableMock = decodableMock as? Entity {
            completionHandler(.success(decodableMock))
        }
    }

}

```

##### And instead `FBENetworkGet` you will use to test the `FBEMockGet` on `MoviesController`
```swift

class MoviesControllerTests: XCTestCase {
    func testDidTouchAtListMoviesWhenHasMoviesThenPresentAllMovies() {
        let mockGet = FBEMockGet()
        let movies = [Movie(name: "Star Wars")]
        mockGet.decodableMock = movies
        let controller = MoviesController(getRequest: mockGet)

        controller.didTouchAtListMovies()

        XCTAssertEqual(controller.moviesQuantity, movies.count)
    }
}
```

# Frisbee next features
- [x] Get request
- [x] Create Carthage distribution
- [x] Create Cocoapod distribution
- [ ] Post request
- [ ] Cache policy
- [ ] Some mock ready for use

