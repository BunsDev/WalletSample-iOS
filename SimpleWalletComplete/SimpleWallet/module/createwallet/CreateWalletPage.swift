//
//  CreateWalletPage.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/23.
//

import SwiftUI

struct CreateWalletPage: View {
    @EnvironmentObject var appState: AppState
    @StateObject var createWalletPresenter: CreateWalletPresenter

    var body: some View {
        VStack {
            Text("Set passwords to protect your account and for backups!")
            SecureField("password", text: $createWalletPresenter.inputPassword)
                .textContentType(.password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                .textInputAutocapitalization(.never)
            Button {
                createWalletPresenter.apply(input: .passwordSaveButtonDidTap)
            } label: {
                Text("Set password")
            }
        }
        .fullScreenCover(isPresented: $createWalletPresenter.passwordSaveSucceeded) {
            TabPage()
        }
    }
}

struct CreateWalletPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateWalletPage(createWalletPresenter: CreateWalletPresenter(interactor: CreateWalletInteractor(useCase: WalletUseCase()), appState: AppState()))
    }
}
