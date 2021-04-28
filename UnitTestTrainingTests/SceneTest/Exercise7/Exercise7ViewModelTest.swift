//
//  Exercise7ViewModelTest.swift
//  UnitTestTrainingTests
//
//  Created by le.thi.diem.my on 4/26/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

@testable import UnitTestTraining
import XCTest
import UIKit
import Reusable
import RxSwift

final class Exercise7ViewModelTest: XCTestCase {
    
    var viewModel: Exercise7ViewModel!
    var navigator: Exercise7NavigatorMock!
    var useCase: Exercise7UseCaseMock!
    var input: Exercise7ViewModel.Input!
    var output: Exercise7ViewModel.Output!
    var disposeBag = DisposeBag()
    
    let loadTrigger = PublishSubject<Void>()
    let isPremiumTrigger = PublishSubject<Bool>()
    let cartAmount = PublishSubject<String>()
    let isSelectQuickDeliver = PublishSubject<Bool>()
    
    override func setUp() {
        navigator = Exercise7NavigatorMock()
        useCase = Exercise7UseCaseMock()
        viewModel = Exercise7ViewModel(navigator: navigator, useCase: useCase)
        
        input = Exercise7ViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
                   isPremiumTrigger: isPremiumTrigger.asDriverOnErrorJustComplete(),
                   cartAmount: cartAmount.asDriverOnErrorJustComplete(),
                   isSelectQuickDeliver: isSelectQuickDeliver.asDriverOnErrorJustComplete())
        output = viewModel.transform(input, disposeBag: disposeBag)
    }
    
    func test_LoadTrigger() {
        loadTrigger.onNext(())
        
        XCTAssertFalse(useCase.isPremiumMember)
        XCTAssertFalse(useCase.isQuickDeliver)
    }
    
    func test_IsPremium() {
        isPremiumTrigger.onNext(true)
        XCTAssertTrue(useCase.isPremiumMember)
    }
    
    func test_isQuickDeliver() {
        isSelectQuickDeliver.onNext(true)
        XCTAssertTrue(useCase.isQuickDeliver)
    }
    
    func test_CardAmoutValid() {
        cartAmount.onNext("100")
        XCTAssert(useCase.validateCardAmountCalled)
        XCTAssert(useCase.validateCardAmount("100").isValid)
    }
    
    func test_CalculateFee_QuickDeliver() {
        isSelectQuickDeliver.onNext(true)
        XCTAssert(useCase.calculationFeeCall)
        XCTAssert(useCase.isQuickDeliver)
        XCTAssertEqual(output.fee.quickFee, 500.0)
    }
}


