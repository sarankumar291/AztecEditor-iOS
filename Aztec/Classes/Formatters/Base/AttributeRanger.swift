import Foundation

public protocol AttributeRanger {
    func applicationRange(for range: NSRange, in text: NSAttributedString) -> NSRange
}
