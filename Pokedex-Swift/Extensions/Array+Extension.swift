//
//  Array+Extension.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 27/06/21.
//

import Foundation
extension Sequence where Element: Hashable {
    func withoutDuplicates() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
