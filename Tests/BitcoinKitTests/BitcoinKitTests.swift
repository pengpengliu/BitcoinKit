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
    
    func testKey() {
        let priv: [UInt8] = Array(hex: "e580512c800c6de3bd5e65695b4cab739211b7ac41ffc2991b0cf75c4d3ccbdf")
        let pub = Bitcoin.Key(priv: priv).pub
        XCTAssertEqual(priv.toHexString(), "e580512c800c6de3bd5e65695b4cab739211b7ac41ffc2991b0cf75c4d3ccbdf")
        XCTAssertEqual(pub.toHexString(), "0254dec37f0858dd993798f8b31ba912eb3cee803ac4209596cc79c804a2f3c201")
        XCTAssertEqual(Bitcoin.Address.toBase58Check(pub), "1CFhS9JqPSkc2HJQpGR6CRcEHjyWvW8trj")
        XCTAssertEqual(Bitcoin.Address.toBech32(pub), "bc1q0dc0tycuky7550akpnd5y4zwedssjzrxnlv402")
    }
    
    func testBitcoinAddress() {
        let pubkey = "0254dec37f0858dd993798f8b31ba912eb3cee803ac4209596cc79c804a2f3c201"
        XCTAssertEqual(Bitcoin.Address.toBase58Check(pubkey), "1CFhS9JqPSkc2HJQpGR6CRcEHjyWvW8trj")
        XCTAssertEqual(Bitcoin.Address.toBech32(pubkey), "bc1q0dc0tycuky7550akpnd5y4zwedssjzrxnlv402")
    }
    
    func testEthereumAddress() {
        let pubkey = "54dec37f0858dd993798f8b31ba912eb3cee803ac4209596cc79c804a2f3c201c5c8c530ebd8af6cce71d1b2250dee29e660b1d10140226a7f5cbff46228de60"
        XCTAssertEqual(Ethereum.Address.encode(pubkey), "0xF97dd426AffA7950167A1796Cb807Db885E26131")
    }
    
    static var allTests = [
        ("testBech32", testBech32),
        ("testKey", testKey),
        ("testBitcoinAddress", testBitcoinAddress),
        ("testEthereumAddress", testEthereumAddress),
    ]
}
