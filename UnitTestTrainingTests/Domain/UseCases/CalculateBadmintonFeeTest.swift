//
//  CalculateBadmintonFeeTest.swift
//  UnitTestTrainingTests
//
//  Created by duong.vi.tuan on 27/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import XCTest
import RxSwift
import RxCocoa

final class CalculateBadmintonFeeTest: XCTestCase, CalculateBadmintonFee {

    override func setUp() {
        super.setUp()
    }
    
    /// Test case 1
    /// - age  < 13
    /// - gender: male
    func test_calculatePlayFee_age_lessthan_13_gender_male() {
        // act
        let expect_fee = 1800.0 / 2.0
        var result = true
        
        for age in 0...12 {
            let dto = BadmintonGameDto(age: "\(age)", isMale: true, playDate: Date())
            let fee = self.calculatePlayFee(dto: dto)
            
            result = result && (fee == expect_fee)
        }
        
        XCTAssertEqual(result, true)
    }
    
    /// Test case 2
    /// - age  < 13
    /// - gender: female
    func test_calculatePlayFee_age_lessthan_13_gender_female() {
        // act
        let expect_fee = 1800.0 / 2.0
        var result = true
        
        for age in 0...12 {
            let dto = BadmintonGameDto(age: "\(age)", isMale: false, playDate: Date())
            let fee = self.calculatePlayFee(dto: dto)
            
            result = result && (fee == expect_fee)
        }
        
        XCTAssertEqual(result, true)
    }
    
    /// Test case 3
    /// - 13 <= age <= 65
    /// - gender: male
    /// - Date In tuesday
    func test_calculatePlayFee_age_morethan_13_gender_male_tuesday() {
        // act
        let expect_fee = 1200.0
        var result = true
        
        let date = Date.createDateWith(dayInWeek: .tuesday)
        for age in 13...65 {
            let dto = BadmintonGameDto(age: "\(age)", isMale: true, playDate: date)
            let fee = self.calculatePlayFee(dto: dto)
            
            result = result && (fee == expect_fee)
        }
        
        // assert
        XCTAssertEqual(result, true)
    }
    
    /// Test case 4
    /// - 13 <= age <= 65
    /// - gender: female
    /// - Date In tuesday
    func test_calculatePlayFee_age_morethan_13_gender_female_tuesday() {
        // act
        let expect_fee = 1200.0
        var result = true
        
        let date = Date.createDateWith(dayInWeek: .tuesday)
        for age in 13...65 {
            let dto = BadmintonGameDto(age: "\(age)", isMale: false, playDate: date)
            let fee = self.calculatePlayFee(dto: dto)
            
            result = result && (fee == expect_fee)
        }
        
        // assert
        XCTAssertEqual(result, true)
    }
    
    /// Test case 5
    /// - 13 <= age <= 65
    /// - gender: male
    /// - Date In friday
    func test_calculatePlayFee_age_morethan_13_gender_male_friday() {
        // act
        let expect_fee = 1800.0
        var result = true
        
        let date = Date.createDateWith(dayInWeek: .friday)
        for age in 13...65 {
            let dto = BadmintonGameDto(age: "\(age)", isMale: true, playDate: date)
            let fee = self.calculatePlayFee(dto: dto)
            
            result = result && (fee == expect_fee)
        }
        
        // assert
        XCTAssertEqual(result, true)
    }
    
    /// Test case 6
    /// - 13 <= age <= 65
    /// - gender: female
    /// - Date In friday
    func test_calculatePlayFee_age_morethan_13_gender_female_friday() {
        // act
        let expect_fee = 1400.0
        var result = true
        
        let date = Date.createDateWith(dayInWeek: .friday)
        for age in 13...65 {
            let dto = BadmintonGameDto(age: "\(age)", isMale: false, playDate: date)
            let fee = self.calculatePlayFee(dto: dto)
            
            result = result && (fee == expect_fee)
        }
        
        // assert
        XCTAssertEqual(result, true)
    }
    
    /// Test case 7
    /// - age > 65
    /// - gender: male
    /// - Date In tuesday
    func test_calculatePlayFee_age_morethan_65_gender_male_tuesday() {
        // act
        let date = Date.createDateWith(dayInWeek: .tuesday)
        let dto = BadmintonGameDto(age: "66", isMale: true, playDate: date)
        let result = self.calculatePlayFee(dto: dto)
        
        // assert
        XCTAssertEqual(result, 1200)
    }
    
    /// Test case 8
    /// - age > 65
    /// - gender: female
    /// - Date In tuesday
    func test_calculatePlayFee_age_morethan_65_gender_female_tuesday() {
        // act
        let date = Date.createDateWith(dayInWeek: .tuesday)
        let dto = BadmintonGameDto(age: "66", isMale: false, playDate: date)
        let result = self.calculatePlayFee(dto: dto)
        
        // assert
        XCTAssertEqual(result, 1200)
    }
    
    /// Test case 9
    /// - age > 65
    /// - gender: male
    /// - Date In friday
    func test_calculatePlayFee_age_morethan_65_gender_male_friday() {
        // act
        let date = Date.createDateWith(dayInWeek: .friday)
        let dto = BadmintonGameDto(age: "66", isMale: true, playDate: date)
        let result = self.calculatePlayFee(dto: dto)
        
        // assert
        XCTAssertEqual(result, 1600.0)
    }
    
    /// Test case 10
    /// - age > 65
    /// - gender: female
    /// - Date In friday
    func test_calculatePlayFee_age_morethan_65_gender_female_friday() {
        // act
        let date = Date.createDateWith(dayInWeek: .friday)
        let dto = BadmintonGameDto(age: "66", isMale: false, playDate: date)
        let result = self.calculatePlayFee(dto: dto)
        
        // assert
        XCTAssertEqual(result, 1400.0)
    }
    
    /// Test case 11
    /// - age number valid (0 -> 120))
    func test_age_input_valid() {
        // act
        var result = true
        
        for age in 0...120 {
            result = result && self.validateAge("\(age)").isValid
        }
        
        // assert
        XCTAssertEqual(result, true)
    }
    
    /// Test case 12
    /// - age number valid age > 120
    func test_age_input_invalid() {
        // act
        let result = self.validateAge("121").isValid
        
        // assert
        XCTAssertEqual(result, false)
    }
    
    /// Test case 12
    /// - age number valid age <= 120
    func test_validateAge_success() {
        let result = self.validateAge("120")
        XCTAssert(result.isValid)
    }
}
