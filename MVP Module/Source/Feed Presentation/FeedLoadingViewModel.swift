//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

struct FeedLoadingViewModel {
	let isLoading: Bool
	let errorMessage: String?
	
	init(isLoading: Bool, errorMessage: String? = nil) {
		self.isLoading = isLoading
		self.errorMessage = errorMessage
	}
}
