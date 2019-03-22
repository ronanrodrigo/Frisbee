![](https://i.imgur.com/67a4vkG.png)

[![Build Status](https://app.bitrise.io/app/27a5e39dc511ba7c/status.svg?token=HZCmnpdBTIy3rOQdUv6HOg&branch=master)](https://app.bitrise.io/app/27a5e39dc511ba7c) [![CocoaPods](https://img.shields.io/cocoapods/v/Frisbee.svg)]() [![CocoaPods](https://img.shields.io/cocoapods/p/Frisbee.svg)]() [![Carthage](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)]() [![codecov](https://codecov.io/gh/ronanrodrigo/frisbee/branch/master/graph/badge.svg)](https://codecov.io/gh/ronanrodrigo/frisbee) [![codebeat badge](https://codebeat.co/badges/f5cf675c-2fca-4689-a42e-a7029a984fe3)](https://codebeat.co/projects/github-com-ronanrodrigo-frisbee-master) [![Join at Telegram](https://img.shields.io/badge/telegram-join-319FD7.svg)](https://t.me/FrisbeeLib) [![Linux Compatible](https://img.shields.io/badge/linux-compatible-brightgreen.svg)]()

---

Another network wrapper for URLSession. Built to be simple, small and easy to create tests at the network layer of your application.

- [Install](#install)
	- [Carthage](#carthage)
	- [CocoaPods](#cocoapods)
	- [Swift Package Manager](#swift-package-manager)
- [Usage](#usage)
	- [GET Request](#get-request)
	- [POST Request](#post-request)
- [Usage in Tests](#usage-in-tests)
- [Frisbee Next Teatures](#frisbee-next-features)
- [Telegram](#telegram)

## Install
#### Carthage
To integrate Frisbee into your Xcode project using Carthage, specify it in your Cartfile:

```
github "ronanrodrigo/Frisbee" ~> 0.2.5
```

Run carthage update to build the framework and drag the built Frisbee.framework into your Xcode project.

#### CocoaPods
To integrate Frisbee into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Frisbee', '0.2.5'
end
```

Then, run the following command:

```bash
$ pod install
```

#### Swift Package Manager
To integrate Frisbee into your Swift Package Manager project, set the dependencies in your `Package.swift`:

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "<Your Packege Name>",
    dependencies: [
        .package(url: "https://github.com/ronanrodrigo/Frisbee.git", from: "0.2.5")
    ],
    targets: [
        .target(name: "<Your Packege Name>", dependencies: ["Frisbee"])
    ]
)
```

## Usage

### GET Request

#### Decodable Entity
A `Response` of a `Request` made in Frisbee will return an enum of `Result<T>`. Where `T` must be a decodable entity. In this guide it will be used a `Movie` entity like bellow.

```swift
struct Movie: Decodable {
    let name: String
}
```

#### Making a Request
You could abstract Frisbee usage in some class and inject an object that conforms to `Getable` protocol. So, in production ready code you will use an instance of `NetworkGet` object.

```swift
class MoviesController {
    private let getRequest: Getable

    // Expect something that conforms to Getable
    init(getRequest: Getable) {
        self.getRequest = getRequest
    }

    func listMovies() {
        getRequest.get(url: someUrl) { moviesResult: Result<[Movie]> in
            switch moviesResult {
                case let .success(movies): print(movies[0].name)
                case let .fail(error): print(error)
            }
        }
    }
}
```

```swift
// Who will call the MoviesController must inject a NetworkGet instance
MoviesController(getRequest: NetworkGet())
```

#### Query Parameters
It is easy to use query ~~strings~~ paramenters. Just create an `Encodable` struct and use it in `get(url:query:onComplete:)` method.

```swift
struct MovieQuery: Encodable {
    let page: Int
}
```

```swift
let query = MovieQuery(page: 10)
NetworkGet().get(url: url, query: query) { (result: Result<Movie>) in
    // ...
}
```

### POST Request
Same way as GET request, Frisbee has a `Postable` protocol. And in prodution ready code you will use an instance of `NetworkPost`.

#### Making Request
It is the same logic as GET request.

```swift
class MoviesController {
    private let postRequest: Postable

    // Expect something that conforms to Postable
    init(postRequest: Postable) {
        self.postRequest = postRequest
    }

    func createMovie() {
        postRequest.post(url: someUrl) { moviesResult: Result<[Movie]> in
            switch moviesResult {
                case let .success(movies): print(movies[0].name)
                case let .fail(error): print(error)
            }
        }
    }
}
```

#### Body Arguments
It is easy to use body paramenters. Just create an `Encodable` struct and use it in `post(url:body:onComplete:)` method.

```swift
struct MovieBody: Encodable {
    let name: String
}
```

```swift
let body = MovieBody(name: "A New Movie")
NetworkPost().post(url: url, body: body) { (result: Result<Movie>) in
    // ...
}
```


## Usage in Tests

In test target code you can create your own `Getable` (or `Postable` as you needed) mock.

```swift
public class MockGet: Getable {
    var decodableMock: Decodable!

    public func get<Entity: Decodable>(url: URL, completionHandler: @escaping (Result<Entity>) -> Void) {
        get(url: url.absoluteString, completionHandler: completionHandler)
    }

    public func get<Entity: Decodable>(url: String, completionHandler: @escaping (Result<Entity>) -> Void) {
        if let decodableMock = decodableMock as? Entity {
            completionHandler(.success(decodableMock))
        }
    }

}

```

And instead `NetworkGet` you will use to test the `MockGet` on `MoviesController`

```swift

class MoviesControllerTests: XCTestCase {
    func testDidTouchAtListMoviesWhenHasMoviesThenPresentAllMovies() {
        let mockGet = MockGet()
        let movies = [Movie(name: "Star Wars")]
        mockGet.decodableMock = movies
        let controller = MoviesController(getRequest: mockGet)

        controller.didTouchAtListMovies()

        XCTAssertEqual(controller.moviesQuantity, movies.count)
    }
}
```

# Frisbee Next Features
- [x] Get request
- [x] Create Carthage distribution
- [x] Create Cocoapod distribution
- [x] Query parameter builder
- [ ] [Issue # 8](https://github.com/ronanrodrigo/Frisbee/issues/8) Implement other HTTP verbs
- [ ] [Issue # 7](https://github.com/ronanrodrigo/Frisbee/issues/7) Ready for use mock
- [ ] [Issue # 2](https://github.com/ronanrodrigo/Frisbee/issues/2) Propagate Swift Errors

# Telegram
To collaborate, resolve questions and find out what's new about the Frisbee library, join the group on Telegram: https://t.me/FrisbeeLib
