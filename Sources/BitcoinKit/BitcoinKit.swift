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
        public static func toBase58Check(_ data: [UInt8], version: [UInt8] = [0x00]) -> String {
            let payload = Data(version + data)
            let checksum = Crypto101.Hash.sha256(Crypto101.Hash.sha256(payload)).prefix(4)
            return Base58.encode(payload + checksum.bytes)
        }
        
        public static func toBech32(_ data: [UInt8], version: [UInt8] = [0x00], prefix: String = "bc") -> String {
            return try! SegwitAddrCoder().encode(hrp: prefix, version: version, program: Data(data))
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

extension Bitcoin {
    public enum Crypto {
        public static func hash160(bytes: [UInt8]) -> [UInt8]{
            return Crypto101.Hash.sha256ripemd160(Data(bytes)).bytes
        }
    }
}
