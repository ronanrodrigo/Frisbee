import XCTest
@testable import FrisbeeTests

XCTMain([
    testCase(NetworkGetterTests.allTests)
    testCase(IntegrationNetworkGetTests.allTests)
    testCase(URLSessionFactoryTests.allTests)
    testCase(URLRequestFactoryTests.allTests)
    testCase(QueryItemBuilderTests.allTests)
    testCase(URLWithQueryBuilderTests.allTests)
    testCase(ResultGeneratorTests.allTests)
])
