import Foundation
import UIKit

public class CiteFormatter: FontFormatter {
    
    // MARK: - Init

    init() {
        super.init(traits: .traitItalic, htmlRepresentationKey: .citeHtmlRepresentation)
    }
    
    override public func applicationRange(for range: NSRange, in text: NSAttributedString) -> NSRange {
        var effectiveRange = NSRange()
        
        let location = min(range.location, max(text.length - 1, 0))
        
        text.attribute(.citeHtmlRepresentation, at: location, effectiveRange: &effectiveRange)
        
        return effectiveRange
    }
}


