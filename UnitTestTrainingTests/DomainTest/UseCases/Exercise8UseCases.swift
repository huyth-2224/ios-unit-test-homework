//
//  Exercise8UseCases.swift
//  UnitTestTrainingTests
//
//  Created by le.thi.diem.my on 4/27/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import Dto
import RxSwift
import XCTest

final class Exercise8UseCases: XCTestCase, CalculateBadmintonFee {
    
    //test age
    func test_ageValid_Nomal() {
        let age = self.validateAge("10")
        XCTAssert(age.isValid)
    }
    
    func test_ageValid_120() {
        let age = self.validateAge("120")
        XCTAssert(age.isValid)
    }
    
    func test_ageValid_Zero() {
        let age = self.validateAge("0")
        XCTAssert(age.isValid)
    }
    
    func test_ageInValid_Negative() {
        let age = self.validateAge("-1")
        XCTAssertFalse(age.isValid)
    }
    
    func test_ageValid_Over120() {
        let age = self.validateAge("121")
        XCTAssertFalse(age.isValid)
    }
    
    //test fee with age < 13
    func test_feeUnder13() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "12", isMale: false, playDate: Date()))
        XCTAssertEqual(fee, 900.0)
    }
    
    //test fee with age = 13
    // date use for test:
    // 27-04-2021: thứ 3
    // 28-04-2021: thứ 4
    // 30-04-2021: thứ 6
    func test_feeEqual13Normal() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "13", isMale: false, playDate: "28-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1800.0)
    }
    
    func test_feeEqual13Tuesday() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "13", isMale: false, playDate: "27-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1200.0)
    }
    
    func test_feeEqual13FridayMale() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "13", isMale: true, playDate: "30-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1800.0)
    }
    
    func test_feeEqual13FridayFemale() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "13", isMale: false, playDate: "30-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1400.0)
    }
    
    //test fee with age > 13 && age < 65
    func test_feeBetween1365Normal() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "22", isMale: false, playDate: "28-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1800.0)
    }
    
    func test_feeBetween1365Tuesday() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "22", isMale: false, playDate: "27-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1200.0)
    }
    
    func test_feeBetween1365FridayMale() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "22", isMale: true, playDate: "30-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1800.0)
    }
    
    func test_feeBetween1365FridayFemale() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "22", isMale: false, playDate: "30-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1400.0)
    }
    
    //test fee with age > 65
    func test_feeOver65Normal() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "66", isMale: false, playDate: "28-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1600.0)
    }
    
    func test_feeOver65Tuesday() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "66", isMale: false, playDate: "27-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1200.0)
    }
    
    func test_feeOver65FridayMale() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "66", isMale: true, playDate: "30-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1600.0)
    }
    
    func test_feeOver65FridayFemale() {
        let fee = self.calculatePlayFee(dto: BadmintonGameDto(age: "66", isMale: false, playDate: "30-04-2021".convertToDate()))
        XCTAssertEqual(fee, 1400.0)
    }
}

