//
//  EthereumUseCase.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import BigInt
import Foundation
import Web3Core
import web3swift

protocol EthereumUseCaseInterface {
    func fetchEtherBalance(for address: EthereumAddress) async -> BigUInt?
    func sendEther(to: EthereumAddress, from: EthereumAddress, amount: BigUInt) async -> String
}

struct EthereumUseCase: EthereumUseCaseInterface {
    private let web3: Web3
    private let transactionBuilder: TransactionBuilder

    init(web3: Web3, transactionBuilder: TransactionBuilder) {
        self.web3 = web3
        self.transactionBuilder = transactionBuilder
    }

    func fetchEtherBalance(for address: EthereumAddress) async -> BigUInt? {
        /* TODO: Ether の残高を取得する */
        return .zero
    }

    func sendEther(to: EthereumAddress, from: EthereumAddress, amount: BigUInt) async -> String {
        /* TODO: Ether を送金する */
        return ""
    }
}
