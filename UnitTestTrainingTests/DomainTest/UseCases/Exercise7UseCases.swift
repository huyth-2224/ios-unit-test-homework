//
//  Exercise7UseCases.swift
//  UnitTestTrainingTests
//
//  Created by le.thi.diem.my on 4/27/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import Dto
import RxSwift
import XCTest

final class Exercise7UseCases: XCTestCase, CaculatingTransportationFee {
    
    func test_ValiateAmout() {
        let amount = self.validateCardAmount("100")
        XCTAssert(amount.isValid)
    }
    
    func test_InvaliateAmout() {
        let amount = self.validateCardAmount("-100")
        XCTAssertFalse(amount.isValid)
    }
    
    func test_InvaliateAmoutWithText() {
        let amount = self.validateCardAmount("xx")
        XCTAssertFalse(amount.isValid)
    }
    
    func test_FeeNormal_Under5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "100", isPremiumMember: false, isQuickDeliver: false))
        XCTAssertEqual(fee.standardFee, 500.0)
        XCTAssertEqual(fee.quickFee, 0.0)
    }
    
    func test_FeeNormal_Equal5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "5000", isPremiumMember: false, isQuickDeliver: false))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 0.0)
    }
    
    func test_FeeNormal_Over500Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "5005", isPremiumMember: false, isQuickDeliver: false))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 0.0)
    }
    
    //QuickDelivery
    func test_Fee_QuickDelivery_Under5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "100", isPremiumMember: false, isQuickDeliver: true))
        XCTAssertEqual(fee.standardFee, 500.0)
        XCTAssertEqual(fee.quickFee, 500.0)
    }
    
    func test_Fee_QuickDelivery_Equal5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "5000", isPremiumMember: false, isQuickDeliver: true))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 500.0)
    }
    
    func test_Fee_QuickDelivery_Over5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "5005", isPremiumMember: false, isQuickDeliver: true))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 500.0)
    }
    
    //Premium
    func test_Fee_Premium_StandardDelivery_Under5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "100", isPremiumMember: true, isQuickDeliver: false))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 0.0)
    }
    
    func test_Fee_Premium_StandardDelivery_Equal5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "5000", isPremiumMember: true, isQuickDeliver: false))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 0.0)
    }
    
    func test_Fee_Premium_StandardDelivery_Over5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "5005", isPremiumMember: true, isQuickDeliver: false))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 0.0)
    }
    
    //
    func test_Fee_Premium_QuickDelivery_Under5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "100", isPremiumMember: true, isQuickDeliver: true))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 500.0)
    }
    
    func test_Fee_Premium_QuickDelivery_Equal5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "5000", isPremiumMember: true, isQuickDeliver: true))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 500.0)
    }
    
    func test_Fee_Premium_QuickDelivery_Over5000Yen() {
        let fee = self.calculationFee(dto: VietnamMartOrderDto(cartAmount: "5000", isPremiumMember: true, isQuickDeliver: true))
        XCTAssertEqual(fee.standardFee, 0.0)
        XCTAssertEqual(fee.quickFee, 500.0)
    }
}
