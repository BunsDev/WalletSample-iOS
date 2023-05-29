//
//  AppStaate.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import Foundation
import Web3Core
import web3swift

final class AppState: ObservableObject {
    @Published var web3: Web3?
    @Published var currentAccount: EthereumAddress = .zero
}
