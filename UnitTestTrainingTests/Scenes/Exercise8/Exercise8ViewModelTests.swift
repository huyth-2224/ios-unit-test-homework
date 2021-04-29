//
//  Exercise8ViewModelTests.swift
//  UnitTestTrainingTests
//
//  Created by pham.the.hung on 27/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import RxSwift
import XCTest


final class Exercise8ViewModelTests: XCTestCase {
    private var viewModel: Exercise8ViewModel!
    private var navigator: Exercise8NavigatorMock!
    private var useCase: Exercise8UseCaseMock!
    private var input: Exercise8ViewModel.Input!
    private var output: Exercise8ViewModel.Output!
    private var disposeBag: DisposeBag!

     //Triggers
    private let loadTrigger = PublishSubject<Void>()
    private let ageTrigger = PublishSubject<String>()
    private let isMaleTrigger = PublishSubject<Bool>()
    private let dateTrigger = PublishSubject<Date>()

    override func setUp() {
        super.setUp()
        navigator = Exercise8NavigatorMock()
        useCase = Exercise8UseCaseMock()
        viewModel = Exercise8ViewModel(navigator: navigator, useCase: useCase)

        input = Exercise8ViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                         ageTrigger: ageTrigger.asDriverOnErrorJustComplete(),
                                         isMaleTrigger: isMaleTrigger.asDriverOnErrorJustComplete(),
                                         dateTrigger: dateTrigger.asDriverOnErrorJustComplete())
        disposeBag = DisposeBag()
        output = viewModel.transform(input, disposeBag: disposeBag)
        output.$errorMessage.asDriver().drive().disposed(by: disposeBag)
        output.$fee.asDriver().drive().disposed(by: disposeBag)
        output.$genderString.asDriver().drive().disposed(by: disposeBag)
    }
    
    func test_loadTrigger_calculationFee() {
        loadTrigger.onNext(())
        
        XCTAssertFalse(useCase.isMale)
        XCTAssertEqual(useCase.age, "0")
        XCTAssertEqual(useCase.date.dayInWeek(), Date().dayInWeek())
        XCTAssert(useCase.calculatePlayFee_Called)
        XCTAssertEqual(output.fee, 10.0)
    }
    
    func test_ageTrigger_calculationFee() {
        ageTrigger.onNext("1")
        // assert
        XCTAssert(useCase.validateAge_Called)
        XCTAssertFalse(useCase.isMale)
        XCTAssertEqual(output.fee, 10.0)
        XCTAssertEqual(useCase.age, "1")
        XCTAssertEqual(useCase.date.dayInWeek(), Date().dayInWeek())
    }

    func test_isMaleTrigger_calculationFee() {
        isMaleTrigger.onNext(true)
        
        XCTAssert(useCase.calculatePlayFee_Called)
        XCTAssert(useCase.isMale)
        XCTAssertEqual(output.fee, 10.0)
        XCTAssertEqual(useCase.age, "0")
        XCTAssertEqual(useCase.date.dayInWeek(), Date().dayInWeek())
    }

    func test_dateTrigger_calculationFee() {
        let date = Date()
        
        // act
        dateTrigger.onNext(date)
        
        // assert
        XCTAssert(useCase.calculatePlayFee_Called)
        XCTAssertFalse(useCase.isMale)
        XCTAssertEqual(output.fee, 10.0)
        XCTAssertEqual(useCase.age, "0")
        XCTAssertEqual(useCase.date, date)
    }
}
