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
        let useCase = WalletUseCase()
        let manager = useCase.loadKeystoreManager()
        let rpcURL = URL(string: "https://rpc.sepolia.org/")!
        guard let provider = try? await Web3HttpProvider(url: rpcURL, network: .sepolia, keystoreManager: manager) else {
            print("provider instantiate failure.")
            return nil
        }

        print("address: \(String(describing: manager?.addresses?.first?.address))")

        return Web3(provider: provider)
    }
}
