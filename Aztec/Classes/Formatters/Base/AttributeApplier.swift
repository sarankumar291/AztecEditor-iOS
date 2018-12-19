import Foundation

public protocol AttributeApplier {
    
    var ranger: AttributeRanger { get }
    
    /// Apply the compound attributes to the provided attributes dictionary.
    ///
    /// - Parameter attributes: the original attributes to apply to
    /// - Returns: the resulting attributes dictionary
    ///
    func apply(to attributes: [NSAttributedStringKey: Any]) -> [NSAttributedStringKey: Any]
    
    /// Apply the compound attributes to the provided attributes dictionary.
    ///
    /// - Parameters:
    ///     - attributes: the original attributes to apply to
    ///     - representation: the original HTML representation for the attribute to apply.
    ///
    /// - Returns:
    ///     - the resulting attributes dictionary
    ///
    func apply(to attributes: [NSAttributedStringKey: Any], andStore representation: HTMLRepresentation?) -> [NSAttributedStringKey: Any]
    
    /// Applies the Formatter's Attributes into a given string, at the specified range.
    ///
    @discardableResult
    func applyAttributes(to string: NSMutableAttributedString, at range: NSRange) -> NSRange
}

extension AttributeApplier {
    
    /// The default implementation forwards the call.  This is probably good enough for all
    /// classes that implement this protocol.
    ///
    public func apply(to attributes: [NSAttributedStringKey: Any]) -> [NSAttributedStringKey: Any] {
        return apply(to: attributes, andStore: nil)
    }
    
    /// Applies the Formatter's Attributes into a given string, at the specified range.
    ///
    /// - Returns: the full range where the attributes where applied
    ///
    @discardableResult
    public func applyAttributes(to text: NSMutableAttributedString, at range: NSRange) -> NSRange {
        let rangeToApply = applicationRange(for: range, in: text)
        
        text.enumerateAttributes(in: rangeToApply, options: []) { (attributes, range, _) in
            let currentAttributes = text.attributes(at: range.location, effectiveRange: nil)
            let attributes = apply(to: currentAttributes)
            text.addAttributes(attributes, range: range)
        }
        
        return rangeToApply
    }
}
