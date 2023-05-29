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
        do {
            let rawBalance = try await web3.eth.getBalance(for: address)
            print("rawBalance: \(String(describing: rawBalance))")
            return rawBalance
        } catch {
            print("fetch ether balance failed: \(error)")
            return nil
        }
    }

    func sendEther(to: EthereumAddress, from: EthereumAddress, amount: BigUInt) async -> String {
        var transaction = await transactionBuilder.buildTransferTransaction(to: to, from: from, value: amount)

        guard let password = KeychainManager.shared.read(key: Constants.Keychain.appPassword, itemClass: .genericPassword) else {
            return ""
        }

        do {
            _ = try web3.wallet.signTX(transaction: &transaction, account: from, password: password)

            guard let encodedTransaction = transaction.encode() else {
                print("encode failed: \(transaction)")
                return ""
            }

            let result = try await web3.eth.send(raw: encodedTransaction)
            return result.hash
        } catch {
            print("error: \(error)")
            return ""
        }
    }
}
