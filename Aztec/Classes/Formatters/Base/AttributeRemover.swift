import Foundation

public protocol AttributeRemover: AttributeRanger {
    
    /// Remove the compound attributes from the provided list.
    ///
    /// - Parameter attributes: the original attributes to remove from
    /// - Returns: the resulting attributes dictionary
    ///
    func remove(from attributes: [NSAttributedStringKey: Any]) -> [NSAttributedStringKey: Any]
    
    /// Removes the Formatter's Attributes from a given string, at the specified range.
    ///
    @discardableResult
    func removeAttributes(from string: NSMutableAttributedString, at range: NSRange) -> NSRange
}

extension AttributeRemover {
    
    /// Removes the Formatter's Attributes from a given string, at the specified range.
    ///
    /// - Returns: the full range where the attributes where removed
    ///
    @discardableResult
    public func removeAttributes(from text: NSMutableAttributedString, at range: NSRange) -> NSRange {
        let rangeToApply = applicationRange(for: range, in: text)
        text.enumerateAttributes(in: rangeToApply, options: []) { (attributes, range, stop) in
            let currentAttributes = text.attributes(at: range.location, effectiveRange: nil)
            let attributes = remove(from: currentAttributes)
            
            let currentKeys = Set(currentAttributes.keys)
            let newKeys = Set(attributes.keys)
            let removedKeys = currentKeys.subtracting(newKeys)
            for key in removedKeys {
                text.removeAttribute(key, range: range)
            }
            
            text.addAttributes(attributes, range: range)
        }
        return rangeToApply
    }
}
