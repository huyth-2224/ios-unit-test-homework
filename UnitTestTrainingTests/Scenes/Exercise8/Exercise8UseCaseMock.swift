//
//  Exercise8UseCaseMock.swift
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

final class Exercise8UseCaseMock: Exercise8UseCaseType {
    var validateAge_Called = false
    func validateAge(_ age: String) -> ValidationResult {
        validateAge_Called = true
        return BadmintonGameDto.validateAge(age).mapToVoid()
    }
    
    var calculatePlayFee_Called = false
    var calculatePlayFee_ReturnValue = (10.0)
    
    func calculatePlayFee(dto: BadmintonGameDto) -> Double {
        calculatePlayFee_Called = true
        return calculatePlayFee_ReturnValue
    }
}
