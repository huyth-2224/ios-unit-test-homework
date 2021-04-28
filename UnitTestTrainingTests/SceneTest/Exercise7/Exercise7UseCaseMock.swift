//
//  Exercise7UseCaseMock.swift
//  UnitTestTrainingTests
//
//  Created by le.thi.diem.my on 4/26/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import Dto
import RxSwift
import ValidatedPropertyKit

final class Exercise7UseCaseMock: Exercise7UseCaseType {
    
    var calculationFeeCall = false
    var standardDeliver = 500.0
    var quickDeliver = 500.0
    var isPremiumMember = false
    var isQuickDeliver = true
    
    func calculationFee(dto: VietnamMartOrderDto) -> (standardFee: Double, quickFee: Double) {
        calculationFeeCall = true
        self.isPremiumMember = dto.isPremiumMember
        self.isQuickDeliver = dto.isQuickDeliver
        return (standardDeliver, quickDeliver)
    }
    
    var validateCardAmountCalled = false
    func validateCardAmount(_ amount: String) -> ValidationResult {
        validateCardAmountCalled = true
        return ValidationResult.success(())
    }
}
