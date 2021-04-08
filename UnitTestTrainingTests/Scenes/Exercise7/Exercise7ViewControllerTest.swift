//
//  Exercise7ViewControllerMock.swift
//  UnitTestTrainingTests
//
//  Created by truong.quoc.tai on 07/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import XCTest
import UIKit
import Reusable


final class Exercise7ViewControllerTest: XCTestCase {

    var viewController: Exercise7ViewController!

    override func setUp() {
        super.setUp()
        viewController = Exercise7ViewController.instantiate()
    }

    func test_ibOutlet() {
        _ = viewController.view
        XCTAssertNotNil(viewController.cartAmountTextField)
        XCTAssertNotNil(viewController.errorLabel)
        XCTAssertNotNil(viewController.totalFeeLabel)
        XCTAssertNotNil(viewController.standardFeeLabel)
        XCTAssertNotNil(viewController.quickTransportFeeLabel)
        XCTAssertNotNil(viewController.membershipSwitch)
        XCTAssertNotNil(viewController.quickDeliverSwitch)
    }
}

