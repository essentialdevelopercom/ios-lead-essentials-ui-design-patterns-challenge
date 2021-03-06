//
//  FeedErrorViewModel.swift
//  MVVMTests
//
//  Created by Salah Amassi on 06/03/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

struct FeedErrorViewModel {
	let error: String?
	
	static var none: FeedErrorViewModel {
		FeedErrorViewModel(error: nil)
	}
	
	static func error(_ error: String) -> FeedErrorViewModel {
		FeedErrorViewModel(error: error)
	}
}
