//
//  Crypto.swift
//  
//
//  Created by Liu Pengpeng on 2020/6/11.
//

import Crypto101
import Foundation

public struct Crypto {
    public static func hash160(bytes: [UInt8]) -> [UInt8]{
        return Crypto101.Hash.sha256ripemd160(Data(bytes)).bytes
    }
}
