//
//  WalletInteractor.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import BigInt
import Foundation
import Web3Core

protocol WalletInteractorInterface {
    func fetchEtherBalance(for address: EthereumAddress) async -> BigUInt?
}

final class WalletInteractor: WalletInteractorInterface {

    private let useCase: EthereumUseCaseInterface

    init(useCase: EthereumUseCaseInterface) {
        self.useCase = useCase
    }

    func fetchEtherBalance(for address: EthereumAddress) async -> BigUInt? {
        await useCase.fetchEtherBalance(for: address)
    }
}
