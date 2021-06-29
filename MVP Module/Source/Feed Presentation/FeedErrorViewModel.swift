//
//  FeedErrorViewModel.swift
//  MVP
//
//  Created by Alexander on 29/6/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

struct FeedErrorViewModel {
	let message: String?

	static var noError: FeedErrorViewModel {
		return FeedErrorViewModel(message: nil)
	}

	static func error(message: String) -> FeedErrorViewModel {
		return FeedErrorViewModel(message: message)
	}
}
