//
//  Exercise8UseCaseMock.swift
//  UnitTestTrainingTests
//
//  Created by duong.vi.tuan on 4/28/21.
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
    
    var isValidateAgeCalled = false
    var validateAgeSuccess = ValidationResult.success(())
    var isCalculatePlayFeeCalled = false
    
    func validateAge(_ age: String) -> ValidationResult {
        isValidateAgeCalled = true
        return validateAgeSuccess
    }
    
    func calculatePlayFee(dto: BadmintonGameDto) -> Double {
        isCalculatePlayFeeCalled = true
        self.age = dto.age
        self.isMale = dto.isMale
        self.date = dto.playDate
        return 100.0
    }
}
