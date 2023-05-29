//
//  SendPresenter.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import Foundation
import Web3Core

final class SendPresenter: ObservableObject {
    enum Input {
        case sendButtonDidTap
    }

    @Published var fromAddress: EthereumAddress = .zero
    @Published var amountString = ""
    @Published var toAddressString = ""
    @Published var isTransactionSended = false

    private let interactor: SendInteractorInterface
    private let formatter: EthereumNumberFormatter

    init(interactor: SendInteractorInterface, formatter: EthereumNumberFormatter, fromAddress: EthereumAddress) {
        self.interactor = interactor
        self.formatter = formatter
        self.fromAddress = fromAddress
    }

    func apply(input: Input) {
        switch input {
        case .sendButtonDidTap:
            sendEther()
        }
    }
}

private extension SendPresenter {
    func sendEther() {
        guard let toAddress = EthereumAddress(from: toAddressString) else {
            return
        }
        guard let amount = formatter.bigUInt(from: amountString, decimals: 18) else {
            return
        }

        Task { @MainActor in
            let transactionHash = await interactor.sendEther(toAddress: toAddress, fromAddress: fromAddress, amount: amount)

            print("Transaction Hash: \(transactionHash)")

            self.isTransactionSended = true
        }
    }
}
