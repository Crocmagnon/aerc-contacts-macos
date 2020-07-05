import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(aerc_contacts_cliTests.allTests),
    ]
}
#endif
