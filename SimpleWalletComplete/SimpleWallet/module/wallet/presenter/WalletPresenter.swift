//
//  WalletPresenter.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import Foundation
import Web3Core

final class WalletPresenter: ObservableObject {
    enum Input {
        case onAppear
        case sendButtonDidTap
    }

    @Published var currentAddress = EthereumAddress.zero
    @Published var etherBalanceString = ""
    @Published var showSendPage = false

    var currentAddressString: String {
        currentAddress.address
    }

    private let interactor: WalletInteractorInterface
    private let formatter: EthereumNumberFormatter

    init(interactor: WalletInteractorInterface, formatter: EthereumNumberFormatter, currentAddress: EthereumAddress) {
        self.interactor = interactor
        self.formatter = formatter
        self.currentAddress = currentAddress

        self.formatter.updateFractionDigitsConfig(digits: 17)
    }

    func apply(input: Input) {
        switch input {
        case .onAppear:
            fetchEtherBalance()
        case .sendButtonDidTap:
            showSendPage = true
        }
    }
}

private extension WalletPresenter {
    func fetchEtherBalance() {
        Task { @MainActor in
            if currentAddress != .zero {
                let balance = await interactor.fetchEtherBalance(for: currentAddress) ?? .zero
                etherBalanceString = formatter.string(from: balance, decimals: 18)
            }
        }
    }
}
