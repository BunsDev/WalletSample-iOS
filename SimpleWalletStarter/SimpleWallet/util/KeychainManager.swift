//
//  KeychainManager.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import Foundation

final class KeychainManager {
    enum ItemClass {
        case genericPassword
        case key

        var stirng: CFString {
            switch self {
            case .genericPassword:
                return kSecClassGenericPassword
            case .key:
                return kSecClassKey
            }
        }
    }

    static let shared = KeychainManager()

    private let service = Bundle.main.bundleIdentifier ?? ""

    private init() {}

    func save(_ string: String, key: String, itemClass: ItemClass) -> Bool {
        guard let data = string.data(using: .utf8, allowLossyConversion: false) else {
            print("failed to convert string to data")
            return false
        }

        return save(data, key: key, itemClass: itemClass)
    }

    func save(_ data: Data, key: String, itemClass: ItemClass) -> Bool {
        let query = [
            kSecValueData: data,
            kSecClass: itemClass.stirng,
            kSecAttrService: service,
            kSecAttrAccount: key
        ] as [CFString : Any] as CFDictionary

        let matchingStatus = SecItemCopyMatching(query, nil)
        switch matchingStatus {
        case errSecItemNotFound:
            let status = SecItemAdd(query, nil)
            return status == noErr
        case errSecSuccess:
            SecItemUpdate(query, [kSecValueData as String: data] as CFDictionary)
            return true
        default:
            print("Failed to save data to keychain: \(matchingStatus)")
            return false
        }
    }

    func read(key: String, itemClass: ItemClass) -> String? {
        readData(key: key, itemClass: itemClass).flatMap { String(data: $0, encoding: .utf8) }
    }

    func readData(key: String, itemClass: ItemClass) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecClass: itemClass.stirng,
            kSecReturnData: true
        ] as [CFString : Any] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        return result as? Data
    }

    func delete(key: String, itemClass: ItemClass) -> Bool {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecClass: itemClass.stirng
        ] as [CFString : Any] as CFDictionary

        let status = SecItemDelete(query)

        return status == noErr
    }
}
