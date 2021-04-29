//
//  Exercise7ViewModelTests.swift
//  UnitTestTrainingTests
//
//  Created by duong.vi.tuan on 27/04/2021.
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
    
    func test_loadTrigger() {
        // act
        loadTrigger.onNext(())
        
        // assert
        XCTAssert(useCase.isCalculationFeeCalled)
        XCTAssertFalse(useCase.isQuickDeliver)
        XCTAssertFalse(useCase.isPremiumMember)
        XCTAssertEqual(output.fee.standardFee, 100.0)
        XCTAssertEqual(output.fee.quickFee, 0.0)
        XCTAssertEqual(useCase.cartAmount, "5000.0")
    }

    func test_isPremiumMemberTrigger() {
        // act
        isPremiumTrigger.onNext(true)
        
        // assert
        XCTAssert(useCase.isCalculationFeeCalled)
        XCTAssertFalse(useCase.isQuickDeliver)
        XCTAssert(useCase.isPremiumMember)
        XCTAssertEqual(output.fee.standardFee, 100.0)
        XCTAssertEqual(output.fee.quickFee, 0.0)
    }
    
    func test_isSelectQuickDeliverTrigger() {
        // act
        isSelectQuickDeliver.onNext(true)
        
        // assert
        XCTAssert(useCase.isCalculationFeeCalled)
        XCTAssert(useCase.isQuickDeliver)
        XCTAssertFalse(useCase.isPremiumMember)
        XCTAssertEqual(output.fee.standardFee, 100.0)
        XCTAssertEqual(output.fee.quickFee, 0.0)
    }
    
    func test_isCartAmountGreaterThan5000Trigger() {
        // act
        cartAmount.onNext("6000.0")
        
        // assert
        XCTAssert(useCase.isCalculationFeeCalled)
        XCTAssertFalse(useCase.isQuickDeliver)
        XCTAssertFalse(useCase.isPremiumMember)
        XCTAssertEqual(useCase.cartAmount, "6000.0")
        XCTAssertEqual(output.fee.standardFee, 100.0)
        XCTAssertEqual(output.fee.quickFee, 0.0)
    }
}
