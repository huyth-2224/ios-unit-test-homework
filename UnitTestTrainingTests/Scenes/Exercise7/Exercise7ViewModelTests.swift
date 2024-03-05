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

final class Exercise7ViewModelTests: XCTestCase {
    private var viewModel: Exercise7ViewModel!
    private var navigator: Exercise7NavigatorMock!
    private var useCase: Exercise7UseCaseMock!
    private var input: Exercise7ViewModel.Input!
    private var output: Exercise7ViewModel.Output!
    private var disposeBag: DisposeBag!
    
    // Triggers
    private let loadTrigger = PublishSubject<Void>()
    private let isPremiumTrigger = PublishSubject<Bool>()
    private let cartAmount = PublishSubject<String>()
    private let isSelectQuickDeliver = PublishSubject<Bool>()
    
    // Outputs

    override func setUp() {
        super.setUp()
        navigator = Exercise7NavigatorMock()
        useCase = Exercise7UseCaseMock()
        viewModel = Exercise7ViewModel(navigator: navigator, useCase: useCase)
        disposeBag = DisposeBag()
        
        input = Exercise7ViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                         isPremiumTrigger: isPremiumTrigger.asDriverOnErrorJustComplete(),
                                         cartAmount: cartAmount.asDriverOnErrorJustComplete(),
                                         isSelectQuickDeliver: isSelectQuickDeliver.asDriverOnErrorJustComplete())
        
        output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.$errorMessage.asDriver().drive().disposed(by: disposeBag)
        output.$fee.asDriver().drive().disposed(by: disposeBag)
    }
    
    func test_loadTrigger_calculationFee() {
        loadTrigger.onNext(())
        let fee = output.$fee.value
        // assert
        XCTAssert(useCase.calculationFee_Called)
        XCTAssertEqual(fee.quickFee, 5.0)
        XCTAssertEqual(fee.standardFee, 10.0)
    }
    
    func test_isPremiumTrigger_calculationFee() {
        isPremiumTrigger.onNext(false)
        let fee = output.$fee.value
        // assert
        XCTAssert(useCase.calculationFee_Called)
        XCTAssertEqual(fee.quickFee, 5.0)
        XCTAssertEqual(fee.standardFee, 10.0)
    }
    
    func test_isSelectQuickDeliver_calculationFee() {
        isSelectQuickDeliver.onNext(false)
        let fee = output.$fee.value
        // assert
        XCTAssert(useCase.calculationFee_Called)
        XCTAssertEqual(fee.quickFee, 5.0)
        XCTAssertEqual(fee.standardFee, 10.0)
    }
    
    func test_cartAmount_calculationFee() {
        cartAmount.onNext("0")
        let fee = output.$fee.value
        // assert
        XCTAssert(useCase.validateCardAmount_Called)
        XCTAssert(useCase.calculationFee_Called)
        XCTAssertEqual(fee.quickFee, 5.0)
        XCTAssertEqual(fee.standardFee, 10.0)
    }

    func test_cartAmount_errorMessage() {
        cartAmount.onNext("")
        let error = output.$errorMessage.value
        
        XCTAssert(useCase.validateCardAmount_Called)
        XCTAssertEqual(error, "Must input number")
    }
}
