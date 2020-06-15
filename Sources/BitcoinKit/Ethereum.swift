//
//  Ethereum.swift
//  
//
//  Created by Liu Pengpeng on 2020/6/15.
//

import Foundation
import CryptoSwift
import Crypto101

public enum Ethereum {
    /*
     https://github.com/ethereum/EIPs/blob/master/EIPS/eip-55.md
    */
    public enum Address {
        public static func encode(_ hex: String) -> String {
            return Address.encode(Array(hex: hex))
        }
        public static func encode(_ pubkey: [UInt8]) -> String {
            let address = Array(pubkey.sha3(.keccak256).suffix(20)).toHexString()
            let hash = address.data(using: .ascii)!.sha3(.keccak256).toHexString()
            return "0x" + zip(address, hash)
                .map { a, h -> String in
                    switch (a, h) {
                    case ("0", _), ("1", _), ("2", _), ("3", _), ("4", _), ("5", _), ("6", _), ("7", _), ("8", _), ("9", _):
                        return String(a)
                    case (_, "8"), (_, "9"), (_, "a"), (_, "b"), (_, "c"), (_, "d"), (_, "e"), (_, "f"):
                        return String(a).uppercased()
                    default:
                        return String(a).lowercased()
                    }
                }
                .joined()
        }
    }
    
    public struct Key {
        public let priv: [UInt8]
        public init(priv: [UInt8]) {
            self.priv = priv
        }
        
        public var pub: [UInt8] {
            return ECC.Key(priv: self.priv).pub
        }
    }
}
