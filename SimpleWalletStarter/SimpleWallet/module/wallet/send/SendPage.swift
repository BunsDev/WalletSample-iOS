//
//  SendPage.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import SwiftUI

struct SendPage: View {
    @ObservedObject var sendPresenter: SendPresenter
    @Binding var isActive: Bool

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: {
                        isActive = false
                    }, label: {
                        Text("キャンセル")
                    })
                }

                Spacer()

                VStack(alignment: .leading) {
                    Text("from")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, 4)
                    Text("\(sendPresenter.fromAddress.address)")
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.textBackground, lineWidth: 1))
                }
                .padding(.bottom, 16)

                VStack(alignment: .leading) {
                    Text("to")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, 4)
                    TextField("", text: $sendPresenter.toAddressString)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(Color.textBackground)
                        .cornerRadius(10)
                }
                .padding(.bottom, 16)

                VStack(alignment: .leading) {
                    Text("amount")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, 4)
                    TextField("", text: $sendPresenter.amountString)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(Color.textBackground)
                        .cornerRadius(10)
                }
                .padding(.bottom, 72)

                Button {
                    sendPresenter.apply(input: .sendButtonDidTap)
                } label: {
                    Text("Send")
                        .padding(.horizontal, 80)
                        .padding(.vertical, 12)
                        .background(Color.main)
                        .cornerRadius(24)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .semibold))
                }

                Spacer()
            }
        }
        .padding(.horizontal, 24)
    }
}

struct SendPage_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
//        SendPage(sendPresenter: SendPresenter(interactor: SendInteractor(useCase: <#T##EthereumUseCaseInterface#>), formatter: <#T##EthereumNumberFormatter#>, fromAddress: <#T##EthereumAddress#>))
    }
}
