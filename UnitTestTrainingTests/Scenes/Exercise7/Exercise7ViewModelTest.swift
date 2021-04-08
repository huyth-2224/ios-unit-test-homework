//
//  Exercise7ViewModelMock.swift
//  UnitTestTrainingTests
//
//  Created by truong.quoc.tai on 07/04/2021.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import XCTest
import RxSwift
import RxCocoa

final class Exercise7ViewModelTest: XCTestCase {
    private var viewModel: Exercise7ViewModel!
    private var navigator: Exercise7NavigatorMock!
    private var useCase: Exercise7UseCaseMock!
    
    private var input: Exercise7ViewModel.Input!
    private var output: Exercise7ViewModel.Output!
    private var disposeBag: DisposeBag!
    
    
    //trigger
    private var loadTrigger = PublishSubject<Void>()
    private var isPremiumTrigger = PublishSubject<Bool>()
    private var cartAmount = PublishSubject<String>()
    private var isSelectQuickDeliver = PublishSubject<Bool>()
    
    override func setUp() {
        super.setUp()
        navigator = Exercise7NavigatorMock()
        useCase = Exercise7UseCaseMock()
        disposeBag = DisposeBag()
        
        viewModel = Exercise7ViewModel(navigator: navigator, useCase: useCase)
        
        input = Exercise7ViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                                         isPremiumTrigger: isPremiumTrigger.asDriverOnErrorJustComplete(),
                                         cartAmount: cartAmount.asDriverOnErrorJustComplete(),
                                         isSelectQuickDeliver: isSelectQuickDeliver.asDriverOnErrorJustComplete())
        
        output = viewModel.transform(input, disposeBag: disposeBag)
    }
    
    func test_loadTrigger_calculationFee() {
        loadTrigger.onNext(())
        
        XCTAssert(useCase.calculationFeeCalled)
        XCTAssertEqual(output.fee.quickFee, 0)
        XCTAssertEqual(output.fee.standardFee, 0)
    }
    
    func test_isPremiumTrigger_true_calculationFee() {
        isPremiumTrigger.onNext(true)
        
        XCTAssert(useCase.calculationFeeCalled)
        XCTAssertEqual(output.fee.standardFee, 0)
    }
    
    func test_isPremiumTrigger_false_calculationFee() {
        isPremiumTrigger.onNext(false)
        
        XCTAssert(useCase.calculationFeeCalled)
        XCTAssertEqual(output.fee.standardFee, 0)
    }
    
    func test_cartAmount_equal5000_calculationFee() {
        cartAmount.onNext("5000")
        
        XCTAssert(useCase.calculationFeeCalled)
        XCTAssertEqual(output.fee.standardFee, 0)
    }
    
    func test_cartAmount_greaterThan5000_calculationFee() {
        cartAmount.onNext("5001")
        
        XCTAssert(useCase.calculationFeeCalled)
        XCTAssertEqual(output.fee.standardFee, 0)
    }
    
    func test_cartAmount_smallerThan5000_calculationFee() {
        cartAmount.onNext("4999")
        
        XCTAssert(useCase.calculationFeeCalled)
        XCTAssertEqual(output.fee.standardFee, 500)
    }
    
    func test_isSelectQuickDeliver_true_calculationFee() {
        isSelectQuickDeliver.onNext(true)
        
        XCTAssert(useCase.calculationFeeCalled)
        XCTAssertEqual(output.fee.quickFee, 500)
    }
    
    func test_isSelectQuickDeliver_false_calculationFee() {
        isSelectQuickDeliver.onNext(false)
        
        XCTAssert(useCase.calculationFeeCalled)
        XCTAssertEqual(output.fee.quickFee, 0)
    }

}
