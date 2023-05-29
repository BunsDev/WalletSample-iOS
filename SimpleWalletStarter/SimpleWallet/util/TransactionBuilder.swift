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
        /* TODO: Transaction を生成する */
        return CodableTransaction(to: .zero)
    }
}
