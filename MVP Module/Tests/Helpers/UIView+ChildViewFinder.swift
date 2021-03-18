//
//  UIView+ChildViewFinder.swift
//  MVPTests
//
//  Created by Tak Mazarura on 18/03/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit

public extension UIView {
	func findChildView(byAccessibilityIdentifier accessibilityIdentifier: String) -> UIView? {
		guard let  match = subviews.first(where: { $0.accessibilityIdentifier == accessibilityIdentifier }) else {
			return subviews.lazy.compactMap {
				$0.findChildView(byAccessibilityIdentifier: accessibilityIdentifier)
			}.first
		}
		return match
	}
}
