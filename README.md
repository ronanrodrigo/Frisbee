[![Build Status](https://www.bitrise.io/app/27a5e39dc511ba7c/status.svg?token=HZCmnpdBTIy3rOQdUv6HOg&branch=master)](https://www.bitrise.io/app/27a5e39dc511ba7c)

# How to use

##### Create some decodable entity
```swift
struct Movie: Decodable {
    let name: String
}
```

##### This are an exemple of some code that will request some data across network.
```swift
class MoviesController {
    private let getRequest: FBEGetable
    var moviesQuantity = 0

    init(getRequest: FBEGetable) {
        self.getRequest = getRequest
    }

    func didTouchAtListMovies() {
        getRequest.get(url: "") { (moviesResult: FBEResult<[Movie]>) in
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

##### And instead `FBENetworkGet` you will use to test the `FBEMoviesMockGet` on `MoviesController`
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
- [ ] Create Carthage framework
- [ ] Create Cocoapod framework
- [ ] Post request
- [ ] Cache policy
- [ ] Some mock ready for use