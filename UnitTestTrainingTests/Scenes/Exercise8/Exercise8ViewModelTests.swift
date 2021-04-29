//
//  Exercise8ViewModelTests.swift
//  UnitTestTrainingTests
//
//  Created by duong.vi.tuan on 4/28/21.
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

    // Triggers
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
    
    func test_loadTrigger() {
        // act
        loadTrigger.onNext(())
        
        // assert
        XCTAssert(useCase.isCalculatePlayFeeCalled)
        XCTAssertFalse(useCase.isMale)
        XCTAssertEqual(output.fee, 100.0)
        XCTAssertEqual(useCase.age, "0")
        XCTAssertEqual(useCase.date.dayInWeek(), Date().dayInWeek())
    }
    
    func test_ageTrigger() {
        // act
        ageTrigger.onNext("1")
        
        // assert
        XCTAssert(useCase.isCalculatePlayFeeCalled)
        XCTAssertFalse(useCase.isMale)
        XCTAssertEqual(output.fee, 100.0)
        XCTAssertEqual(useCase.age, "1")
        XCTAssertEqual(useCase.date.dayInWeek(), Date().dayInWeek())
    }
    
    func test_isMaleTrigger() {
        // act
        isMaleTrigger.onNext(true)
        
        // assert
        XCTAssert(useCase.isCalculatePlayFeeCalled)
        XCTAssert(useCase.isMale)
        XCTAssertEqual(output.fee, 100.0)
        XCTAssertEqual(useCase.age, "0")
        XCTAssertEqual(useCase.date.dayInWeek(), Date().dayInWeek())
    }
    
    func test_dateTrigger() {
        let date = Date()
        
        // act
        dateTrigger.onNext(date)
        
        // assert
        XCTAssert(useCase.isCalculatePlayFeeCalled)
        XCTAssertFalse(useCase.isMale)
        XCTAssertEqual(output.fee, 100.0)
        XCTAssertEqual(useCase.age, "0")
        XCTAssertEqual(useCase.date, date)
    }
}
