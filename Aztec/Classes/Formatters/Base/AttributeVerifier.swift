import Foundation

public protocol AttributeVerifier {
    
    /// Checks if the attribute is present in a given Attributed String at the specified index.
    ///
    func present(in text: NSAttributedString, at index: Int) -> Bool
    
    /// Checks if the attribute is present in a dictionary of attributes.
    ///
    func present(in attributes: [NSAttributedStringKey: Any]) -> Bool
}

extension AttributeVerifier {
    
    /// Indicates whether the Formatter's Attributes are present in a given string, at a specified Index.
    ///
    public func present(in text: NSAttributedString, at index: Int) -> Bool {
        let safeIndex = max(min(index, text.length - 1), 0)
        let attributes = text.attributes(at: safeIndex, effectiveRange: nil)
        return present(in: attributes)
    }
    
    /// Indicates whether the Formatter's Attributes are present in the full range provided
    ///
    /// - Parameters:
    ///   - text: the attributed string to inspect for the attribute
    ///   - range: the range to inspect
    ///
    /// - Returns: true if the attributes exists on all of the range
    ///
    public func present(in text: NSAttributedString, at range: NSRange) -> Bool {
        if range.length == 0 {
            return present(in: text, at: range.location)
        }
        var result = true
        var enumerateAtLeastOnce = false
        text.enumerateAttributes(in: range, options: []) { (attributes, range, stop) in
            enumerateAtLeastOnce = true
            result = present(in: attributes) && result
            if !result {
                stop.pointee = true
            }
        }
        return result && enumerateAtLeastOnce
    }
}
