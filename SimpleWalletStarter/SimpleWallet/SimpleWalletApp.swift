//
//  SimpleWalletApp.swift
//  SimpleWallet
//
//  Created by yuichiro_takahashi on 2023/05/29.
//

import BigInt
import SwiftUI
import web3swift
import Web3Core

@main
struct SimpleWalletApp: App {
    private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    let web3 = await instantiateWeb3()
                    let currentAccount = (try? web3?.wallet.getAccounts().first) ?? .zero
                    appState.web3 = web3
                    appState.currentAccount = currentAccount
                }
                .environmentObject(appState)
        }
    }
}

private extension SimpleWalletApp {
    func instantiateWeb3() async -> Web3? {
        /* TODO: Web3 をインスタンス化する */
        return .mock
    }
}
