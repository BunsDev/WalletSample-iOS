//
//  CreateWalletInteractor.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import Foundation
import Web3Core

protocol CreateWalletInteractorInterface {
    func createInitialAccount() -> KeystoreManager?
    func loadKeystoreManager() -> KeystoreManager?
}

final class CreateWalletInteractor: CreateWalletInteractorInterface {
    private let useCase: WalletUseCaseInterface

    init(useCase: WalletUseCaseInterface) {
        self.useCase = useCase
    }

    func createInitialAccount() -> KeystoreManager? {
        useCase.createInitialAccount()
    }

    func loadKeystoreManager() -> KeystoreManager? {
        useCase.loadKeystoreManager()
    }
}
