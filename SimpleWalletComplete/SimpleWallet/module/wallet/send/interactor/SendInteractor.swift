//
//  SendInteractor.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import BigInt
import Foundation
import Web3Core

protocol SendInteractorInterface {
    func sendEther(toAddress: EthereumAddress, fromAddress: EthereumAddress, amount: BigUInt) async -> String
}

final class SendInteractor: SendInteractorInterface {
    private let useCase: EthereumUseCaseInterface

    init(useCase: EthereumUseCaseInterface) {
        self.useCase = useCase
    }

    func sendEther(toAddress: EthereumAddress, fromAddress: EthereumAddress, amount: BigUInt) async -> String {
        await useCase.sendEther(to: toAddress, from: fromAddress, amount: amount)
    }
}
