//
//  CreateWalletPresenter.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import Foundation

final class CreateWalletPresenter: ObservableObject {
    enum Input {
        case passwordSaveButtonDidTap
    }

    @Published var inputPassword = ""
    @Published var passwordSaveSucceeded = false

    private let interactor: CreateWalletInteractorInterface

    private var appState: AppState

    init(interactor: CreateWalletInteractorInterface, appState: AppState) {
        self.interactor = interactor
        self.appState = appState
    }

    func apply(input: Input) {
        switch input {
        case .passwordSaveButtonDidTap:
            _ = KeychainManager.shared.save(inputPassword,
                                            key: Constants.Keychain.appPassword,
                                            itemClass: .genericPassword)
            createWallet()

            passwordSaveSucceeded = true
        }
    }
}

private extension CreateWalletPresenter {
    func createWallet() {
        let manager = interactor.createInitialAccount()
        appState.currentAccount = manager?.addresses?.first ?? .zero
        appState.web3?.addKeystoreManager(manager)
    }
}
