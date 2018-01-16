import XCTest
@testable import FrisbeeTests

var allTests = [
    testCase(IntegrationNetworkGetTests.allTests),
    testCase(IntegrationNetworkPostTests.allTests),
    testCase(URLSessionFactoryTests.allTests),
    testCase(URLRequestFactoryTests.allTests),
    testCase(QueryItemAdapterTests.allTests),
    testCase(URLQueryAdapterTests.allTests),
    testCase(ResultGeneratorTests.allTests),
    testCase(FrisbeeErrorTests.allTests),
    testCase(BodyAdapterTests.allTests),
    testCase(ResultTests.allTests)
]

XCTMain(allTests)
