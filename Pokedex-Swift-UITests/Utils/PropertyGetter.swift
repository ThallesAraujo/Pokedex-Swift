//
//  PropertyGetter.swift
//  Pokedex-Swift
//
//  Created by Thalles Araújo on 08/08/21.
//

import Foundation
class PropertyGetter{
    
    static func getValueFrom(_ item: Any?, forKey key: String) -> String?{
        return item.debugDescription.split(separator: ";").first(where: {$0.contains(key)})?.split(separator: "=")[1].components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    }
    
    
}
