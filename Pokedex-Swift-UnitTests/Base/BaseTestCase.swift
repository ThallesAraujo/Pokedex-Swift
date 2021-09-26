//
//  XCTestCase+Extension.swift
//  Pokedex-Swift-UnitTests
//
//  Created by Thalles Araújo on 19/09/21.
//

import XCTest
import RxSwift
import RxCocoa

let responseFailure = APIExpectationConstants.responseFailure.rawValue
let waitingResponse = APIExpectationConstants.waitingResponse.rawValue

class BaseTestCase: XCTestCase{
    
    var disposeBag = DisposeBag()
    let errorBinder: BehaviorRelay<Bool> = BehaviorRelay<Bool>.init(value: false)
    let expectation = XCTestExpectation(description: waitingResponse)
    
    
    func errorBinderSubscribe(){
        errorBinder.subscribe(onNext: {[weak self] errorHasOccurred in
            if errorHasOccurred{
                XCTFail(responseFailure)
                guard let weakself = self else {return}
                weakself.expectation.fulfill()
            }
        }).disposed(by: disposeBag)
    }
    
    func complete(){
        errorBinderSubscribe()
        wait(for: [expectation], timeout: 10.0)
    }
    
}
