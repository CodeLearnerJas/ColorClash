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
}

func openURL(_ urlString: String) {
    if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
    }
}
