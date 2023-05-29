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
        let initialPath = "m/44'/60'/0'/0/0"
        guard let mnemonics = generateMnemonic() else { return nil }
        guard let password = getPassword() else { return nil }
        guard let keystore = createKeystore(from: mnemonics, prefixPath: initialPath, password: password) else { return nil }
        guard let keyParams = getEncodedKeyParams(from: keystore) else { return nil }

        _ = KeychainManager.shared.save(mnemonics, key: Constants.Keychain.mnemonics, itemClass: .genericPassword)
        _ = KeychainManager.shared.save(keyParams, key: Constants.Keychain.privateKey, itemClass: .genericPassword)

        return KeystoreManager([keystore])
    }

    func loadKeystoreManager() -> KeystoreManager? {
        let keychainManager = KeychainManager.shared
        guard let keyParams = keychainManager.readData(key: Constants.Keychain.privateKey, itemClass: .genericPassword) else {
            print("keyData is empty.")
            return nil
        }

        guard let keystore = BIP32Keystore(keyParams) else {
            print("keystore is nil.")
            return nil
        }

//        print("address: \(String(describing: keystore.addresses?.first?.address))")

        return KeystoreManager([keystore])
    }
}

private extension WalletUseCase {
    func generateMnemonic() -> String? {
        do {
            // ニーモニックフレーズを生成する
            let mnemonics = try BIP39.generateMnemonics(bitsOfEntropy: 128)
//            print("mnemonics: \(String(describing: mnemonics))")
            return mnemonics
        } catch {
            print("generate mnemonic failed: \(error)")
            return nil
        }
    }

    func getPassword() -> String? {
        guard let password = KeychainManager.shared.read(key: Constants.Keychain.appPassword, itemClass: .genericPassword) else {
            return nil
        }

        return password
    }

    func createKeystore(from mnemonics: String, prefixPath: String, password: String) -> BIP32Keystore? {
        do {
            let keystore = try BIP32Keystore(mnemonics: mnemonics, password: password, prefixPath: prefixPath)
//            print("address: \(keystore?.addresses?.first?.address as Any)")
            return keystore
        } catch {
            print("generate keystore failed: \(error)")
            return nil
        }
    }

    func getEncodedKeyParams(from keystore: BIP32Keystore) -> Data? {
        do {
            return try JSONEncoder().encode(keystore.keystoreParams)
        } catch {
            print("keyParams encode failed: \(error)")
            return nil
        }
    }
}

