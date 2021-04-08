//
//  Exercise8UseCaseMock.swift
//  UnitTestTrainingTests
//
//  Created by truong.quoc.tai on 08/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import XCTest
import RxSwift
import RxCocoa
import Dto

class Exercise8UseCaseMock: Exercise8UseCaseType {

    var calculatePlayFeeCalled = false
    
    func validateAge(_ age: String) -> ValidationResult {
        return BadmintonGameDto.validateAge(age).mapToVoid()
    }
    
    func calculatePlayFee(dto: BadmintonGameDto) -> Double {
        calculatePlayFeeCalled = true
        guard dto.validationError == nil else { return 0.0 }
        
        if dto.ageValue < 13 {
            return 1800.0 / 2
        }
        
        if dto.playDate.dayInWeek() == .tuesday {
            return 1200.0
        }
        
        if !dto.isMale && dto.playDate.dayInWeek() == .friday {
            return 1400.0
        }
        
        if dto.ageValue > 65 {
            return 1600.0
        }
        
        return 1800.0
    }
    

}
