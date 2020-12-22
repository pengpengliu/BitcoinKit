# BitcoinKit

## Address Generation

```swift
let pubkey = "0254dec37f0858dd993798f8b31ba912eb3cee803ac4209596cc79c804a2f3c201"
Address.toBase58Check(pubkey) // 1CFhS9JqPSkc2HJQpGR6CRcEHjyWvW8trj
Address.toBech32(pubkey)  // bc1q0dc0tycuky7550akpnd5y4zwedssjzrxnlv402
```
