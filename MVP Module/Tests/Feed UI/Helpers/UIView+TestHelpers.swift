//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

extension UIView {
    func simulateTapGesture() {
        let tapGestureRecognizers = self.gestureRecognizers?.filter { $0 is UITapGestureRecognizer }
        tapGestureRecognizers?.forEach {

            // Not working :(
            let touch = UITouch()
            let event = UIEvent()

            $0.touchesBegan(Set([touch]), with: event)
            $0.touchesEnded(Set([touch]), with: event)
        }
    }
}

