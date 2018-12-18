import UIKit

public class BoldFormatter: FontFormatter {
    init() {
        super.init(traits: .traitBold, htmlRepresentationKey: .boldHtmlRepresentation)
    }
}
