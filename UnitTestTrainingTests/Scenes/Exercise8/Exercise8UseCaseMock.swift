//
//  Exercise8UseCaseMock.swift
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

final class Exercise8UseCaseMock: Exercise8UseCaseType {
    var isMale = false
    var age: String?
    var date = Date()
    
    var validateAge_Called = false
    func validateAge(_ age: String) -> ValidationResult {
        validateAge_Called = true
        return BadmintonGameDto.validateAge(age).mapToVoid()
    }
    
    var calculatePlayFee_Called = false
    var calculatePlayFee_ReturnValue = (10.0)
    
    func calculatePlayFee(dto: BadmintonGameDto) -> Double {
        calculatePlayFee_Called = true
        age = dto.age
        isMale = dto.isMale
        date = dto.playDate
        return calculatePlayFee_ReturnValue
    }
}
