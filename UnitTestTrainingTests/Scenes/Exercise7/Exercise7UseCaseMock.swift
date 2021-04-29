//
//  Exercise7UseCaseMock.swift
//  UnitTestTrainingTests
//
//  Created by duong.vi.tuan on 27/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import RxSwift
import ValidatedPropertyKit
import Dto

final class Exercise7UseCaseMock: Exercise7UseCaseType {
    
    var cartAmount: String?
    var isPremiumMember = false
    var isQuickDeliver = false
    var isCalculationFeeCalled = false
    var isValidateCardAmountCalled = false
    var validateCartAmountSuccess = ValidationResult.success(())
    
    func calculationFee(dto: VietnamMartOrderDto) -> (standardFee: Double, quickFee: Double) {
        self.isCalculationFeeCalled = true
        self.cartAmount = dto.cartAmount
        self.isPremiumMember = dto.isPremiumMember
        self.isQuickDeliver = dto.isQuickDeliver
       
        return (standardFee: 100.0, quickFee: 0.0)
    }
    
    func validateCardAmount(_ amount: String) -> ValidationResult {
        isValidateCardAmountCalled = true
        return validateCartAmountSuccess
    }
    
}
