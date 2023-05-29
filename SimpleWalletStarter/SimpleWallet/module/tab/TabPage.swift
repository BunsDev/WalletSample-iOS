//
//  TabPage.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import SwiftUI

struct TabPage: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            WalletPage(walletPresenter: WalletPresenter(interactor: WalletInteractor(useCase: EthereumUseCase(web3: appState.web3!, transactionBuilder: TransactionBuilder(web3: appState.web3!))), formatter: EthereumNumberFormatter(), currentAddress: appState.currentAccount))
        }
    }
}

struct TabPage_Previews: PreviewProvider {
    static var previews: some View {
        TabPage()
    }
}
