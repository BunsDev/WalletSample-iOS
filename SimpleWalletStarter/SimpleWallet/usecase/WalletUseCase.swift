//
//  WalletUseCase.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import Foundation
import Web3Core

protocol WalletUseCaseInterface {
    func createInitialAccount() -> KeystoreManager?
    func loadKeystoreManager() -> KeystoreManager?
}

struct WalletUseCase: WalletUseCaseInterface {
    func createInitialAccount() -> KeystoreManager? {
        /* TODO: Wallet を生成 */
        return nil
    }

    func loadKeystoreManager() -> KeystoreManager? {
        /* TODO: 保存した情報から Wallet を復元 */
        return nil
    }
}

private extension WalletUseCase {
    func getPassword() -> String? {
        guard let password = KeychainManager.shared.read(key: Constants.Keychain.appPassword, itemClass: .genericPassword) else {
            return nil
        }

        return password
    }

    func generateMnemonic() -> String? {
        /* TODO: ニーモニックフレーズを生成する */
        return nil
    }

    func createKeystore(from mnemonics: String, prefixPath: String, password: String) -> BIP32Keystore? {
        /* TODO: ニーモニックから Wallet を生成する */
        return nil
    }

    func getEncodedKeyParams(from keystore: BIP32Keystore) -> Data? {
        /* TODO: Wallet の KeyParams を取得する */
        return nil
    }
}

