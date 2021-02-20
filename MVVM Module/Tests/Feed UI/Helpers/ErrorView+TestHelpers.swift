//
//  ErrorView+TestHelpers.swift
//  MVVMTests
//
//  Created by Eric Garlock on 2/20/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import MVVM

extension ErrorView {
	var isShowing: Bool {
		return alpha == 1
	}
}
