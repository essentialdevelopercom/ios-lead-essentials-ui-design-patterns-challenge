//
//  FeedErrorViewModel.swift
//  MVP
//
//  Created by Khoi Nguyen on 23/11/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

struct FeedErrorViewModel {
    let message: String?
    
    var shouldShowErrorMessage: Bool {
        return message != nil
    }
}
