import Base58
import Crypto101
import Foundation
import CryptoSwift

public enum Bitcoin {
}

/*
 Address: https://en.bitcoin.it/w/images/en/4/48/Address_map.jpg
 */
extension Bitcoin {
    /*
     Legacy & Script
     https://en.bitcoin.it/wiki/List_of_address_prefixes
    */
    public enum Address {
        public static func toBase58Check(_ pubkey: String, version: [UInt8] = [0x00]) -> String {
            return Address.toBase58Check(Array(hex: pubkey), version: version)
        }
        public static func toBase58Check(_ pubkey: [UInt8], version: [UInt8] = [0x00]) -> String {
            let payload = Data(version + Crypto.hash160(bytes: pubkey))
            let checksum = Crypto101.Hash.sha256(Crypto101.Hash.sha256(payload)).prefix(4)
            return Base58.encode(payload + checksum.bytes)
        }
        
        public static func toBech32(_ pubkey: String, version: [UInt8] = [0x00], prefix: String = "bc") -> String {
            return Address.toBech32(Array(hex: pubkey), version: version, prefix: prefix)
        }
        public static func toBech32(_ pubkey: [UInt8], version: [UInt8] = [0x00], prefix: String = "bc") -> String {
            return try! SegwitAddrCoder().encode(hrp: prefix, version: version, program: Data(Crypto.hash160(bytes: pubkey)))
        }
    }
}

extension Bitcoin {
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
