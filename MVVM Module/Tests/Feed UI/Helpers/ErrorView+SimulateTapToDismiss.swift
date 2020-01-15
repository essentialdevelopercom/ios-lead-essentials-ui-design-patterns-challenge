//
//  ErrorView+SimulateTapToDismiss.swift
//  MVVMTests
//
//  Created by Pusca, Ghenadie on 1/15/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import UIKit
import MVVM

extension ErrorView {
    func simulateMessageDismiss() {
        button.simulateTap()
    }
}
