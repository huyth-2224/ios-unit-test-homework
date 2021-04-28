//
//  Exercise8ViewModelTest.swift
//  UnitTestTrainingTests
//
//  Created by le.thi.diem.my on 4/26/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import RxSwift
import XCTest

final class Exercise8ViewModelTest: XCTestCase {
    
    var navigator: Exercise8NavigatorMock!
    var useCase: Exercise8UseCaseMock!
    var viewModel: Exercise8ViewModel!
    var input: Exercise8ViewModel.Input!
    var output: Exercise8ViewModel.Output!
    
    let loadTrigger = PublishSubject<Void>()
    let ageTrigger = PublishSubject<String>()
    let isMaleTrigger = PublishSubject<Bool>()
    let dateTrigger = PublishSubject<Date>()
    
    var disposeBag = DisposeBag()
    
    override func setUp() {
        
        navigator = Exercise8NavigatorMock()
        useCase = Exercise8UseCaseMock()
        viewModel = Exercise8ViewModel(navigator: navigator, useCase: useCase)
        
        input = Exercise8ViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                         ageTrigger: ageTrigger.asDriverOnErrorJustComplete(),
                                         isMaleTrigger: isMaleTrigger.asDriverOnErrorJustComplete(),
                                         dateTrigger: dateTrigger.asDriverOnErrorJustComplete())
        output = viewModel.transform(input, disposeBag: disposeBag)
        
    }
    
    func test_LoadTrigger() {
        loadTrigger.onNext(())
        XCTAssertTrue(useCase.calculatePlayFeeCalled)
        XCTAssertEqual(useCase.calculatePlayFeeReturnValue, 1200.0)
    }
    
    func test_isMale() {
        isMaleTrigger.onNext(true)
        XCTAssertEqual(output.genderString, "Nam")
    }
    
    func test_isFemale() {
        isMaleTrigger.onNext(false)
        XCTAssertEqual(output.genderString, "Nữ")
    }
    
    func test_ageValid() {
        ageTrigger.onNext("25")
        XCTAssert(useCase.validateAgeCalled)
        XCTAssert(useCase.validateAge("25").isValid)
    }
}
