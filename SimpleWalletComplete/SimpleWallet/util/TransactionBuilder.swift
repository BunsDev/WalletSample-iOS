//
//  TransactionBuilder.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import BigInt
import Foundation
import Web3Core
import web3swift

struct TransactionBuilder {
    let policyResolver: PolicyResolver

    init(web3: Web3) {
        self.policyResolver = PolicyResolver(provider: web3.provider)
    }

    func buildTransferTransaction(to: EthereumAddress, from: EthereumAddress, value: BigUInt) async -> CodableTransaction {
        // 1. CodableTransaction をインスタンス化
        var transaction = CodableTransaction(type: .eip1559, to: to, chainID: BigUInt(11155111), value: value)
        transaction.from = from

        do {
            // 2. nonce を計算
            let nonce = try await policyResolver.resolveNonce(for: transaction, with: .latest)
            transaction.nonce = nonce

            // 3. 必要なガスの量と価格を計算
            let gasLimit = try await policyResolver.resolveGasEstimate(for: transaction, with: .automatic)
            let baseFee = await policyResolver.resolveGasBaseFee(for: .automatic)
            let maxPriorityFeePerGas = await policyResolver.resolveGasPriorityFee(for: .automatic)
            let maxFeePerGas = (baseFee * 2) + maxPriorityFeePerGas

            transaction.gasLimit = gasLimit
            transaction.maxPriorityFeePerGas = maxPriorityFeePerGas
            transaction.maxFeePerGas = maxFeePerGas
        } catch {
            print("error: \(error)")
        }

        return transaction
    }
}
