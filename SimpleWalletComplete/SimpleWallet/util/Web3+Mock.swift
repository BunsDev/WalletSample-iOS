//
//  Web3+Mock.swift
//  SimpleWallet
//
//  Created by yuichiro_takahashi on 2023/05/29.
//

import Foundation
import web3swift

extension Web3 {
    static let mock = Web3(provider: Web3HttpProvider(url: URL(string: "https://rpc.sepolia.org/")!, network: .sepolia))
}
