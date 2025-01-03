//
//  VersionManager.swift
//  ColorClash
//
//  Created by GuitarLearnerJas on 3/1/2025.
//

import SwiftUI

class VersionManager: ObservableObject {
    @Published var isUpdateAvailable = false
    @Published var showUpdateAlert = false
    
    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    
    func checkForUpdates() {
        // Replace with your App Store ID
        let appStoreID = URLManager().appleStoreID
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(appStoreID)") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let appStoreVersion = results.first?["version"] as? String else {
                return
            }
            
            DispatchQueue.main.async {
                self?.isUpdateAvailable = self?.compareVersions(appStore: appStoreVersion, current: self?.currentVersion ?? "") ?? false
                if self?.isUpdateAvailable ?? false {
                    self?.showUpdateAlert = true
                }
            }
        }.resume()
    }
    
    private func compareVersions(appStore: String, current: String) -> Bool {
        let appStoreComponents = appStore.split(separator: ".").compactMap { Int($0) }
        let currentComponents = current.split(separator: ".").compactMap { Int($0) }
        
        for i in 0..<min(appStoreComponents.count, currentComponents.count) {
            if appStoreComponents[i] > currentComponents[i] {
                return true
            } else if appStoreComponents[i] < currentComponents[i] {
                return false
            }
        }
        return appStoreComponents.count > currentComponents.count
    }
    
    func openAppStore() {
        if let url = URL(string: URLManager().appleStoreURL) {
            UIApplication.shared.open(url)
        }
    }
}
