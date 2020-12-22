import XCTest
import CryptoSwift
@testable import BitcoinKit

final class BitcoinKitTests: XCTestCase {
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
    
    func testBitcoinAddress() {
        let pubkey = "0254dec37f0858dd993798f8b31ba912eb3cee803ac4209596cc79c804a2f3c201"
        XCTAssertEqual(Address.toBase58Check(pubkey), "1CFhS9JqPSkc2HJQpGR6CRcEHjyWvW8trj")
        XCTAssertEqual(Address.toBech32(pubkey), "bc1q0dc0tycuky7550akpnd5y4zwedssjzrxnlv402")
    }
    
    static var allTests = [
        ("testBech32", testBech32),
        ("testBitcoinAddress", testBitcoinAddress),
    ]
}
