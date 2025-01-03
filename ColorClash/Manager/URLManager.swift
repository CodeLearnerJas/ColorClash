//
//  URLManager.swift
//  ColorClash
//
//  Created by GuitarLearnerJas on 3/1/2025.
//

import SwiftUI

struct URLManager {
    let projectURL = "https://jjtech.super.site/projects/colorclash"
    let privacyURL = "https://jjtech.super.site/projects/colorclash/privacy-policy"
    let termsURL = "https://jjtech.super.site/projects/colorclash/terms-and-services"
    let appleStoreURL = "https://apps.apple.com/au/app/color-clash/id6740109244"
    let appleStoreID = "id6740109244"
}

func openURL(_ urlString: String) {
    if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
    }
}
