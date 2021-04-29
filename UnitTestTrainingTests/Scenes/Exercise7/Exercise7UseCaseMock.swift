//
//  Exercise7UseCaseMock.swift
//  UnitTestTrainingTests
//
//  Created by pham.the.hung on 27/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import ValidatedPropertyKit
import Dto
import RxSwift
import XCTest

final class Exercise7UseCaseMock: Exercise7UseCaseType {
    var cartAmount: String?
    var isPremiumMember = false
    var isQuickDeliver = false
    
    var calculationFee_Called = false
    var calculationFee_ReturnValue = (10.0, 5.0)
    
    func calculationFee(dto: VietnamMartOrderDto) -> (standardFee: Double, quickFee: Double) {
        calculationFee_Called = true
        cartAmount = dto.cartAmount
        isPremiumMember = dto.isPremiumMember
        isQuickDeliver = dto.isQuickDeliver
        return calculationFee_ReturnValue
    }
        
    var validateCardAmount_Called = false
    
    func validateCardAmount(_ amount: String) -> ValidationResult {
        validateCardAmount_Called = true
        return VietnamMartOrderDto.validateCartAmount(amount).mapToVoid()
    }
}
