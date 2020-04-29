//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

public final class ErrorView: UIView {

    @IBOutlet public var errorButton: UIButton!
	
	public var message: String? {
        get { return isVisible ? errorButton.titleLabel?.text : nil }
	}
	
	private var isVisible: Bool {
		return alpha > 0
	}
	
	public override func awakeFromNib() {
		super.awakeFromNib()
		
        setButtonTitle(nil)
		alpha = 0
	}
	
	func show(message: String) {
        setButtonTitle(message)
		
		UIView.animate(withDuration: 0.25) {
			self.alpha = 1
		}
	}
	
	@IBAction func hideMessage() {
		UIView.animate(
			withDuration: 0.25,
			animations: { self.alpha = 0 },
			completion: { completed in
				if completed { self.setButtonTitle(nil) }
		})
	}
    
    private func setButtonTitle(_ title: String?) {
        errorButton.setTitle(title, for: .normal)
    }
}
