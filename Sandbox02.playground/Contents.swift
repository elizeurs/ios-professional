import UIKit

// @:?!()$#,./\
let text = "@?!()$#,./\\"
let specialCharacterRegex = "[@:?!()$#,./\\\\]+"
text.range(of: specialCharacterRegex, options: .regularExpression) != nil
