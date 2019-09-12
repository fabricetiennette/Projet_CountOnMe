//
//  CountOnMeViewModelTests.swift
//  CountOnMeTests
//
//  Created by Fabrice Etiennette on 12/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeViewModelTests: XCTestCase {

    var countViewModel: CountViewModel!

    override func setUp() {
        countViewModel = CountViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        countViewModel = nil
        super.tearDown()
    }

    func testMakeElements() {
        let text = "123"
        let elements = countViewModel.makeElements(from: text)
        XCTAssertEqual(elements, ["123"])
    }

}
