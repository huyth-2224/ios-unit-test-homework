//
//  Exercise8ViewControllerTest.swift
//  UnitTestTrainingTests
//
//  Created by truong.quoc.tai on 08/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//
@testable import UnitTestTraining
import XCTest

class Exercise8ViewControllerTest: XCTestCase {
    var viewController: Exercise8ViewController!
    
    override func setUp() {
        super.setUp()
        viewController = Exercise8ViewController.instantiate()
    }

    func test_iboutlet() {
        _ = viewController.view
        XCTAssertNotNil(viewController.ageTextField)
        XCTAssertNotNil(viewController.errorMessageLabel)
        XCTAssertNotNil(viewController.genderSwitch)
        XCTAssertNotNil(viewController.datePicker)
        XCTAssertNotNil(viewController.feeLabel)
        XCTAssertNotNil(viewController.genderLabel)
    }
}
