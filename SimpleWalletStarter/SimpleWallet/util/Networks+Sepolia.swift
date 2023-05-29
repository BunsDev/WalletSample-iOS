//
//  Networks+Sepolia.swift
//  SimpleWallet
//
//  Created by yuichiro_takahashi on 2023/05/29.
//

import BigInt
import Web3Core

extension Networks {
    static let sepolia = Networks.Custom(networkID: BigUInt(11155111))
}
