//
//  Exercise7ViewControllerTest.swift
//  UnitTestTrainingTests
//
//  Created by le.thi.diem.my on 4/26/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import XCTest
import UIKit
import Reusable

final class Exercise7ViewControllerTest: XCTestCase {
    
    var vc: Exercise7ViewController!
    
    override func setUp() {
        super.setUp()
        
        vc = Exercise7ViewController.instantiate()
    }
    
    func testOutlets() {
        _ = vc.view
        XCTAssertNotNil(vc.cartAmountTextField)
        XCTAssertNotNil(vc.errorLabel)
        XCTAssertNotNil(vc.totalFeeLabel)
        XCTAssertNotNil(vc.standardFeeLabel)
        XCTAssertNotNil(vc.quickTransportFeeLabel)
        XCTAssertNotNil(vc.membershipSwitch)
        XCTAssertNotNil(vc.quickDeliverSwitch)
    }
}
