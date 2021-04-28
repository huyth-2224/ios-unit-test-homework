//
//  Exercise8ViewModelTests.swift
//  UnitTestTrainingTests
//
//  Created by nguyen.vuong.thanh.loc on 4/28/21.
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
        let fee = output.$fee.value
        // assert
        XCTAssert(useCase.calculatePlayFee_Called)
        XCTAssertEqual(fee, 10.0)
    }
    
    func test_ageTrigger_calculationFee() {
        ageTrigger.onNext("1")
        let error = output.$errorMessage.value
        // assert
        XCTAssert(useCase.validateAge_Called)
        XCTAssertEqual(error, "")
    }

    func test_isMaleTrigger_calculationFee() {
        isMaleTrigger.onNext(true)
        let gender = output.$genderString.value
        // assert
        XCTAssert(useCase.calculatePlayFee_Called)
        XCTAssertEqual(gender, "Nam")
    }

    func test_dateTrigger_calculationFee() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: "2021/04/22")
        dateTrigger.onNext(date!)
        let fee = output.$fee.value
        // assert
        XCTAssert(useCase.calculatePlayFee_Called)
        XCTAssertEqual(fee, 10.0)
    }
}
