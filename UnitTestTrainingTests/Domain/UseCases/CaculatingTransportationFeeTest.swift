//
//  CaculatingTransportationFeeTest.swift
//  UnitTestTrainingTests
//
//  Created by pham.the.hung on 27/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import XCTest
import RxSwift
import RxCocoa

class CaculatingTransportationFeeTest: XCTestCase, CaculatingTransportationFee {

    override func setUp() {
        super.setUp()
    }
    
    /// Test case 1
    /// - cartAmount less than 5000
    /// - Not Premium
    /// - Not QuickDeliver
    func test_calculationFee_lessthan_5000_not_premiumMember_and_not_quickDeliver() {
        // act
        let dto = VietnamMartOrderDto(cartAmount: "4000", isPremiumMember: false, isQuickDeliver: false)
        let result = self.calculationFee(dto: dto)
        
        // assert
        let (standardDeliver, quickDeliver) = result
        XCTAssertEqual(standardDeliver, 500.0)
        XCTAssertEqual(quickDeliver, 0.0)
    }
    
    /// Test case 2
    /// - cartAmount less than 5000
    /// - Is Premium
    /// - Not QuickDeliver
    func test_calculationFee_lessthan_5000_is_premiumMember_and_not_quickDeliver() {
        // act
        let dto = VietnamMartOrderDto(cartAmount: "4000", isPremiumMember: true, isQuickDeliver: false)
        let result = self.calculationFee(dto: dto)
        
        // assert
        let (standardDeliver, quickDeliver) = result
        XCTAssertEqual(standardDeliver, 0.0)
        XCTAssertEqual(quickDeliver, 0.0)
    }
    
    /// Test case 3
    /// - cartAmount less than 5000
    /// - Not Premium
    /// - Is QuickDeliver
    func test_calculationFee_lessthan_5000_not_premiumMember_and_is_quickDeliver() {
        // act
        let dto = VietnamMartOrderDto(cartAmount: "4000", isPremiumMember: false, isQuickDeliver: true)
        let result = self.calculationFee(dto: dto)
        
        // assert
        let (standardDeliver, quickDeliver) = result
        XCTAssertEqual(standardDeliver, 500.0)
        XCTAssertEqual(quickDeliver, 500.0)
    }
    
    /// Test case 4
    /// - cartAmount less than 5000
    /// - Is Premium
    /// - Is QuickDeliver
    func test_calculationFee_lessthan_5000_is_premiumMember_and_is_quickDeliver() {
        // act
        let dto = VietnamMartOrderDto(cartAmount: "4000", isPremiumMember: true, isQuickDeliver: true)
        let result = self.calculationFee(dto: dto)
        
        // assert
        let (standardDeliver, quickDeliver) = result
        XCTAssertEqual(standardDeliver, 0.0)
        XCTAssertEqual(quickDeliver, 500.0)
    }
    
    /// Test case 5
    /// - cartAmount more than or equal 5000
    /// - Not Premium
    /// - Not QuickDeliver
    func test_calculationFee_morethan_5000_not_premiumMember_and_not_quickDeliver() {
        // act
        let dto = VietnamMartOrderDto(cartAmount: "5000", isPremiumMember: false, isQuickDeliver: false)
        let result = self.calculationFee(dto: dto)
        
        // assert
        let (standardDeliver, quickDeliver) = result
        XCTAssertEqual(standardDeliver, 0.0)
        XCTAssertEqual(quickDeliver, 0.0)
    }
    
    /// Test case 6
    /// - cartAmount more than or equal 5000
    /// - Is Premium
    /// - Not QuickDeliver
    func test_calculationFee_morethan_5000_is_premiumMember_and_not_quickDeliver() {
        // act
        let dto = VietnamMartOrderDto(cartAmount: "5000", isPremiumMember: true, isQuickDeliver: false)
        let result = self.calculationFee(dto: dto)
        
        // assert
        let (standardDeliver, quickDeliver) = result
        XCTAssertEqual(standardDeliver, 0.0)
        XCTAssertEqual(quickDeliver, 0.0)
    }
    
    /// Test case 7
    /// - cartAmount more than or equal 5000
    /// - Not Premium
    /// - Is QuickDeliver
    func test_calculationFee_morethan_5000_not_premiumMember_and_is_quickDeliver() {
        // act
        let dto = VietnamMartOrderDto(cartAmount: "5000", isPremiumMember: false, isQuickDeliver: true)
        let result = self.calculationFee(dto: dto)
        
        // assert
        let (standardDeliver, quickDeliver) = result
        XCTAssertEqual(standardDeliver, 0.0)
        XCTAssertEqual(quickDeliver, 500.0)
    }
    
    /// Test case 8
    /// - cartAmount more than or equal 5000
    /// - Is Premium
    /// - Is QuickDeliver
    func test_calculationFee_morethan_5000_is_premiumMember_and_is_quickDeliver() {
        // act
        let dto = VietnamMartOrderDto(cartAmount: "5000", isPremiumMember: true, isQuickDeliver: true)
        let result = self.calculationFee(dto: dto)
        
        // assert
        let (standardDeliver, quickDeliver) = result
        XCTAssertEqual(standardDeliver, 0.0)
        XCTAssertEqual(quickDeliver, 500.0)
    }
    
    /// Test case 9
    /// - validateCardAmount number valid
    func test_calculationFee_input_valid() {
        // act
        let validateCardAmount = self.validateCardAmount("1000")
        
        // assert
        XCTAssertEqual(validateCardAmount.isValid, true)
    }
    
    /// Test case 10
    /// - validateCardAmount number invalid
    func test_calculationFee_input_invalid() {
        // act
        let validateCardAmount = self.validateCardAmount("abc")
        
        // assert
        XCTAssertEqual(validateCardAmount.isValid, false)
    }

}
