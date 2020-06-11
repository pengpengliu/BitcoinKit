//
//  File.swift
//  
//
//  Created by Liu Pengpeng on 2020/6/11.
//

import Foundation

public extension Array where Element == UInt8 {
    init(hex: String) {
        self.init()
        let len = hex.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hex.index(hex.startIndex, offsetBy: i * 2)
            let k = hex.index(j, offsetBy: 2)
            let bytes = hex[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            }
        }
        
        append(contentsOf: Array(data))
    }
    
    var hex: String {
        return reduce("") { $0 + String(format: "%02x", $1) }
    }
}
