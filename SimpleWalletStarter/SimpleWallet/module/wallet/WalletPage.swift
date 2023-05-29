//
//  WalletPage.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import SwiftUI
import Web3Core

struct WalletPage: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var walletPresenter: WalletPresenter

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    HStack {
                        Text("Etehreum")
                            .padding(.trailing, 4)
                            .font(.system(size: 12, weight: .medium))
                        Text("Seporia")
                            .font(.system(size: 11))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.textBackground)
                    .cornerRadius(20)
                    Spacer()
                }
                .padding(.leading, 12)

                Spacer()

                VStack(spacing: 0) {
                    Text("Account1")
                        .padding(.bottom, 8)
                        .font(.system(size: 24, weight: .semibold))
                    Text("\(walletPresenter.currentAddressString)")
                        .padding(.bottom, 20)
                        .font(.system(size: 20, weight: .semibold))
                    Text("\(walletPresenter.etherBalanceString) ETH")
                        .font(.system(size: 48, weight: .semibold))
                        .padding(.bottom, 24)
                    Button {
                        walletPresenter.apply(input: .sendButtonDidTap)
                    } label: {
                        Text("Send")
                            .padding(.horizontal, 80)
                            .padding(.vertical, 12)
                            .background(Color.main)
                            .cornerRadius(24)
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
        .onAppear {
            walletPresenter.apply(input: .onAppear)
        }
        .fullScreenCover(isPresented: $walletPresenter.showSendPage, content: {
            SendPage(sendPresenter: SendPresenter(interactor: SendInteractor(useCase: EthereumUseCase(web3: appState.web3!, transactionBuilder: TransactionBuilder(web3: appState.web3!))), formatter: EthereumNumberFormatter(), fromAddress: appState.currentAccount), isActive: $walletPresenter.showSendPage)
        })
    }
}

struct WalletPage_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
//        WalletPage(walletPresenter: WalletPresenter(interactor: WalletInteractor(useCase: EthereumUseCase(web3: Web3(provider: Web))), formatter: EthereumNumberFormatter(), currentAddress: EthereumAddress.zero))
    }
}
