//
//  Exercise8UseCaseMock.swift
//  UnitTestTrainingTests
//
//  Created by le.thi.diem.my on 4/26/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import ValidatedPropertyKit
import Dto

final class Exercise8UseCaseMock: Exercise8UseCaseType {
    
    var validateAgeCalled = false
    
    func validateAge(_ age: String) -> ValidationResult {
        validateAgeCalled = true
        return ValidationResult.success(())
    }
    
    
    var calculatePlayFeeCalled = false
    var calculatePlayFeeReturnValue: Double = 1200
    
    func calculatePlayFee(dto: BadmintonGameDto) -> Double {
        calculatePlayFeeCalled = true
        return calculatePlayFeeReturnValue
    }
}
