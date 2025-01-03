//
//  GameKitManager.swift
//  ColorClash
//
//  Created by GuitarLearnerJas on 3/1/2025.
//

import GameKit
import SwiftUI

class GameKitManager: NSObject, ObservableObject {
    @Published var isGameCenterEnabled = false
    @Published var isShowingGameCenter = false
    
    static let shared = GameKitManager()
    
    // TODO: Leaderboard IDs - replace these with your actual IDs from App Store Connect
    private let highestStageLeaderboardID = "your.highestStage.leaderboard.id"
    private let highestScoreLeaderboardID = "your.highestScore.leaderboard.id"
    
    override init() {
        super.init()
        authenticateUser()
    }
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [weak self] viewController, error in
            if let viewController = viewController {
                // Present the view controller if needed
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    rootViewController.present(viewController, animated: true)
                }
            } else if let error = error {
                print("Game Center authentication error: \(error.localizedDescription)")
            } else {
                self?.isGameCenterEnabled = GKLocalPlayer.local.isAuthenticated
                print("Game Center Authentication Success")
            }
        }
    }
    
    func showGameCenter() {
        if !GKLocalPlayer.local.isAuthenticated {
            authenticateUser()
            return
        }
        
        let viewController = GKGameCenterViewController(state: .default)
        viewController.gameCenterDelegate = self
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(viewController, animated: true)
        }
    }
    
    func submitScore(stage: Int, score: Int) {
        guard GKLocalPlayer.local.isAuthenticated else { return }
        
        // Submit highest stage
        Task {
            do {
                try await GKLeaderboard.submitScore(
                    stage,  // stage is already Int
                    context: 0,
                    player: GKLocalPlayer.local,
                    leaderboardIDs: [highestStageLeaderboardID]
                )
                print("Stage score submitted successfully")
            } catch {
                print("Error submitting stage score: \(error.localizedDescription)")
            }
        }
        
        // Submit highest score
        Task {
            do {
                try await GKLeaderboard.submitScore(
                    score,  // score is already Int
                    context: 0,
                    player: GKLocalPlayer.local,
                    leaderboardIDs: [highestScoreLeaderboardID]
                )
                print("Game score submitted successfully")
            } catch {
                print("Error submitting game score: \(error.localizedDescription)")
            }
        }
    }
}

extension GameKitManager: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}
