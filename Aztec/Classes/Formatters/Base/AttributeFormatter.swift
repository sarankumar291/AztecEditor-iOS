import UIKit


/// A type that provides support for toggling compound attributes in an attributed string.
///
/// When you want to represent an attribute that does not have a 1-1 correspondence with a standard
/// attribute, it is useful to have a virtual attribute. 
/// Toggling this attribute would also toggle the attributes for its defined style.
///
public protocol AttributeFormatter {
    
    var applier: AttributeApplier { get }
    var remover: AttributeRemover { get }
    var verifier: AttributeVerifier { get }

    /// Toggles an attribute in the specified range of a text storage, and returns the new 
    /// Selected Range. This is required because, in several scenarios, we may need to add a "Zero Width Space",
    /// just to get the style to render properly.
    ///
    /// - Parameters:
    ///     - text: Text that should be formatted.
    ///     - range: Segment of text which format should be toggled.
    ///
    /// - Returns: the full range where the toggle was applied
    ///
    @discardableResult
    func toggle(in text: NSMutableAttributedString, at range: NSRange) -> NSRange

    /// Apply or removes formatter attributes to the provided attribute dictionary and returns it.
    ///
    /// - Parameter attributes: attributes to be checked.
    /// - Returns: the new attribute dictionary with the toggle applied.

    @discardableResult
    func toggle(in attributes: [NSAttributedStringKey: Any]) -> [NSAttributedStringKey: Any]
}


// MARK: - Default Implementations
//
extension AttributeFormatter {

    @discardableResult
    public func toggle(in attributes: [NSAttributedStringKey: Any]) -> [NSAttributedStringKey: Any] {
        if present(in: attributes) {
            return remove(from: attributes)
        } else {
            return apply(to: attributes)
        }
    }

    /// Toggles the Attribute Format, into a given string, at the specified range.
    ///
    @discardableResult
    public func toggle(in text: NSMutableAttributedString, at range: NSRange) -> NSRange {
        //We decide if we need to apply or not the attribute based on the value on the initial position of the range
        let shouldApply = shouldApplyAttributes(to: text, at: range)

        if shouldApply {
            return applyAttributes(to: text, at: range)
        } else {
            return removeAttributes(from: text, at: range)
        }        
    }
}


// MARK: - Private Helpers
//
private extension AttributeFormatter {

    /// Helper that indicates whether if we should format the specified range, or not. 
    /// -   Note: For convenience reasons, whenever the Text is empty, this helper will return *true*.
    ///
    func shouldApplyAttributes(to text: NSAttributedString, at range: NSRange) -> Bool {
        guard text.length > 0 else {
            return true
        }

        return present(in: text, at: range) == false
    }
}
