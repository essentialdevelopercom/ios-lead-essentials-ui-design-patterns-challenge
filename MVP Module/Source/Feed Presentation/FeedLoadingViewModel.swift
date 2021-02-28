//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

struct FeedLoadingViewModel {
	let isLoading: Bool
	let error: Error?
	
	init(isLoading: Bool, error: Error? = nil) {
		self.isLoading = isLoading
		self.error = error
	}
}
