//
//  Exercise7VUseCaseMock.swift
//  UnitTestTrainingTests
//
//  Created by truong.quoc.tai on 07/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

import XCTest
@testable import UnitTestTraining
import RxSwift
import Foundation
import Dto

class Exercise7UseCaseMock: Exercise7UseCaseType, CaculatingTransportationFee {
    
    var calculationFeeCalled = false
    
    func calculationFee(dto: VietnamMartOrderDto) -> (standardFee: Double, quickFee: Double) {
        calculationFeeCalled = true
        guard dto.validationError == nil else { return (0, 0) }
        
        var standardDeliver = 500.0
        var quickDeliver = 0.0
        
        if dto.cartAmountValue >= 5000 || dto.isPremiumMember {
            standardDeliver = 0.0
        }
        
        if dto.isQuickDeliver {
            quickDeliver = 500.0
        }
        return (standardDeliver, quickDeliver)
    }
    
    func validateCardAmount(_ amount: String) -> ValidationResult {
        return VietnamMartOrderDto.validateCartAmount(amount).mapToVoid()
    }
}
