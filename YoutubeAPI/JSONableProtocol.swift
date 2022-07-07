//
//  JSONableProtocol.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 06.07.2022.
//

import Foundation

protocol JSONable {}

extension JSONable {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}
