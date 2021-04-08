//
//  Exercise8ViewModelTest.swift
//  UnitTestTrainingTests
//
//  Created by truong.quoc.tai on 08/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import XCTest
import RxSwift
import RxCocoa

class Exercise8ViewModelTest: XCTestCase {

    var viewModel: Exercise8ViewModel!
    var navigator: Exercise8NavigatorMock!
    var userCase: Exercise8UseCaseMock!
    var disposebag: DisposeBag!
    
    private var input: Exercise8ViewModel.Input!
    private var output: Exercise8ViewModel.Output!
    
    private var loadTrigger = PublishSubject<Void>()
    private var ageTrigger = PublishSubject<String>()
    private var isMaleTrigger = PublishSubject<Bool>()
    private var dateTrigger = PublishSubject<Date>()
    
    private let genderFemaleString = "Nữ"
    
    override func setUp() {
        super.setUp()
        navigator = Exercise8NavigatorMock()
        userCase = Exercise8UseCaseMock()
        disposebag = DisposeBag()
        
        viewModel = Exercise8ViewModel(navigator: navigator, useCase: userCase)
        
        input = Exercise8ViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                         ageTrigger: ageTrigger.asDriverOnErrorJustComplete(),
                                         isMaleTrigger: isMaleTrigger.asDriverOnErrorJustComplete(),
                                         dateTrigger: dateTrigger.asDriverOnErrorJustComplete())
        output = viewModel.transform(input, disposeBag: disposebag)
        
    }
    
    func test_loadTrigger() {
        loadTrigger.onNext(())
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 1800)
    }
    
    
    func test_ageTrigger_lestThan13_calculatePlayFee() {
        ageTrigger.onNext("12")
        
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 900)
    }
    
    func test_ageTrigger_greaterOrEqualThan13_andNotTuesDayAndNotFridayAndIsMale_calculatePlayFee() {
        //Equal
        ageTrigger.onNext("13")
        
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 1800)
        
        //Greater
        ageTrigger.onNext("14")
        
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 1800)
    }
    
    func test_ageTrigger_greaterThan65_andNotTuesDayAndNotFridayAndIsMale_calculatePlayFee() {
        ageTrigger.onNext("66")
        
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 1600)
    }
    
    func test_isNotMaleTriggerAndIsFridateTriggerAndAgeTrigger_calculatePlayFee() {
        dateTrigger.onNext("2021/04/09".toDate())
        isMaleTrigger.onNext(false)
        
        ageTrigger.onNext("13")
        
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 1400)
        
        
        userCase.calculatePlayFeeCalled = false
        ageTrigger.onNext("12")
        
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 900)
        
    }
    
    func test_isNotMaleTriggerAndIsNotFridateTriggerAndAgeTrigger_calculatePlayFee() {
        dateTrigger.onNext("2021/04/08".toDate())
        isMaleTrigger.onNext(false)
        
        ageTrigger.onNext("12")
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 900)
        
        ageTrigger.onNext("13")
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 1800)
        
        ageTrigger.onNext("66")
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 1600)
    }
    
    
    func test_isTuesdateTrigger_calculatePlayFee() {
        dateTrigger.onNext("2021/04/06".toDate())
        ageTrigger.onNext("13")
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 1200)
        
        ageTrigger.onNext("12")
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 900)
    }
    
    func test_validAge() {
        ageTrigger.onNext("-1")
        
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 0)
        XCTAssertEqual(output.errorMessage.isEmpty, false)
        
        ageTrigger.onNext("121")
        
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertEqual(output.fee, 0)
        XCTAssertEqual(output.errorMessage.isEmpty, false)
        
        ageTrigger.onNext("50")
        
        XCTAssert(userCase.calculatePlayFeeCalled)
        XCTAssertNotEqual(output.fee, 0)
        XCTAssertEqual(output.errorMessage.isEmpty, true)
    }
}
