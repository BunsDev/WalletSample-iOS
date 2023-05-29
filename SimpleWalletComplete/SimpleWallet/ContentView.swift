//
//  ContentView.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        if appState.web3 != nil {
            if appState.currentAccount == .zero {
                WelcomePage()
            } else {
                TabPage()
            }
        } else {
            SplashPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
