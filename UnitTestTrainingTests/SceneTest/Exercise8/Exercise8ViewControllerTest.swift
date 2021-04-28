//
//  Exercise8ViewControllerTest.swift
//  UnitTestTrainingTests
//
//  Created by le.thi.diem.my on 4/26/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import XCTest
import UIKit

final class Exercise8ViewControllerTest: XCTestCase {
    
    var vc: Exercise8ViewController!
    
    override func setUp() {
        vc = Exercise8ViewController.instantiate()
    }
    
    func test_IBOutlet() {
        _ = vc.view
        XCTAssertNotNil(vc.ageTextField)
        XCTAssertNotNil(vc.errorMessageLabel)
        XCTAssertNotNil(vc.genderSwitch)
        XCTAssertNotNil(vc.datePicker)
        XCTAssertNotNil(vc.feeLabel)
        XCTAssertNotNil(vc.genderLabel)
    }
}
