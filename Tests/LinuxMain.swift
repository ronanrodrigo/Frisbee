import XCTest
@testable import FrisbeeTests

var allTests = [
    testCase(IntegrationNetworkGetTests.allTests),
    testCase(URLSessionFactoryTests.allTests),
    testCase(URLRequestFactoryTests.allTests),
    testCase(QueryItemBuilderTests.allTests),
    testCase(URLWithQueryBuilderTests.allTests),
    testCase(ResultGeneratorTests.allTests),
    testCase(FrisbeeErrorTests.allTests),
    testCase(ResultTests.allTests)
]

#if !os(Linux)
allTests.append(testCase(NetworkPostTests.allTests))
allTests.append(testCase(NetworkGetTests.allTests))
#endif

XCTMain(allTests)
