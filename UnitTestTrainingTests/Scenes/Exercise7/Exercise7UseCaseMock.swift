//
//  Exercise8ViewModelTests.swift
//  UnitTestTrainingTests
//
//  Created by nguyen.vuong.thanh.loc on 4/28/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import ValidatedPropertyKit
import Dto
import RxSwift
import XCTest

final class Exercise7UseCaseMock: Exercise7UseCaseType {
    var calculationFee_Called = false
    var calculationFee_ReturnValue = (10.0, 5.0)
    
    func calculationFee(dto: VietnamMartOrderDto) -> (standardFee: Double, quickFee: Double) {
        calculationFee_Called = true
        return calculationFee_ReturnValue
    }
        
    var validateCardAmount_Called = false
    
    func validateCardAmount(_ amount: String) -> ValidationResult {
        validateCardAmount_Called = true
        return VietnamMartOrderDto.validateCartAmount(amount).mapToVoid()
    }
}
