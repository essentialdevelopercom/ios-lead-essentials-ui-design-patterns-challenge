//
//  UIView+ChildViewFinder.swift
//  MVVMTests
//
//  Created by Tak Mazarura on 20/03/2021.
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
