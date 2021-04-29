//
//  Exercise8ViewControllerTests.swift
//  UnitTestTrainingTests
//
//  Created by pham.the.hung on 27/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import Reusable
import UIKit
import XCTest

final class Exercise8ViewControllerTests: XCTestCase {
    var viewController: Exercise8ViewController!

    override func setUp() {
        super.setUp()
        viewController = Exercise8ViewController.instantiate()
    }

    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.errorMessageLabel)
        XCTAssertNotNil(viewController.genderSwitch)
        XCTAssertNotNil(viewController.datePicker)
        XCTAssertNotNil(viewController.feeLabel)
        XCTAssertNotNil(viewController.genderLabel)
    }
}
