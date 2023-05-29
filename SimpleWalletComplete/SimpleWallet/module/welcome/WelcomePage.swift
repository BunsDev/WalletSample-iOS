//
//  WelcomePage.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/23.
//

import SwiftUI

struct WelcomePage: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Simple Wallet!")

                NavigationLink {
                    CreateWalletPage(createWalletPresenter: CreateWalletPresenter(interactor: CreateWalletInteractor(useCase: WalletUseCase()), appState: appState))
                } label: {
                    Text("Create new Wallet")
                }
            }
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
