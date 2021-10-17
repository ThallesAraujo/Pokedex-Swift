//
//  KIF+SwiftExtension.swift
//  Pokedex-Swift-UITests
//
//  Created by Thalles Araújo on 07/08/21.
//

import Foundation
import KIF
// swiftlint:disable colon

extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func viewTester(_ file : String = #file, _ line : Int = #line) -> KIFUIViewTestActor {
            return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
        }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
