import XCTest
@testable import BitcoinKit

final class BitcoinKitTests: XCTestCase {
    func testExample() {
        let hash160: [UInt8] = [0x8a, 0x06, 0xf0, 0xc6, 0x97, 0x58, 0xc2, 0x5a, 0x26, 0x72, 0xfc, 0xdf, 0xad, 0xdc, 0xc0, 0x81, 0x17, 0x18, 0xde, 0x75]
        XCTAssertEqual(Bitcoin.Address.toBase58Check(hash160), "1DapZi8PsZfuah3vcaDJZnKrpg8xuqPfJX")
    }

    func testBech32() {
        XCTAssertNoThrow(try Bech32().decode("A12UEL5L"))
        XCTAssertNoThrow(try Bech32().decode("a12uel5l"))
        XCTAssertNoThrow(try Bech32().decode("an83characterlonghumanreadablepartthatcontainsthenumber1andtheexcludedcharactersbio1tt5tgs"))
        XCTAssertNoThrow(try Bech32().decode("abcdef1qpzry9x8gf2tvdw0s3jn54khce6mua7lmqqqxw"))
        XCTAssertNoThrow(try Bech32().decode("11qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqc8247j"))
        XCTAssertNoThrow(try Bech32().decode("split1checkupstagehandshakeupstreamerranterredcaperred2y9e3w"))
        XCTAssertThrowsError(try Bech32().decode("pzry9x0s0muk"))
        XCTAssertEqual(try Bech32().decode("bc1q0dc0tycuky7550akpnd5y4zwedssjzrxnlv402").checksum.first, 0)
        XCTAssertEqual(try Bech32().decode("bc1q0dc0tycuky7550akpnd5y4zwedssjzrxnlv402").checksum.last, 6)
    }
    
    func testAddress() {
        let pubKeyHash: [UInt8] = [0x7b, 0x70, 0xf5, 0x93, 0x1c, 0xb1, 0x3d, 0x4a, 0x3f, 0xb6, 0x0c, 0xdb, 0x42, 0x54, 0x4e, 0xcb, 0x61, 0x09, 0x08, 0x66]
        
        XCTAssertEqual(Bitcoin.Address.toBase58Check(pubKeyHash), "1CFhS9JqPSkc2HJQpGR6CRcEHjyWvW8trj")
        XCTAssertEqual(Bitcoin.Address.toBech32(pubKeyHash), "bc1q0dc0tycuky7550akpnd5y4zwedssjzrxnlv402")
    }
    
    static var allTests = [
        ("testExample", testExample),
        ("testBech32", testBech32),
        ("testAddress", testAddress),
    ]
}
