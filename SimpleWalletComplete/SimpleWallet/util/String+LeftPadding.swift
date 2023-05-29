//
//  String+LeftPadding.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import Foundation

extension String {
    func leftPadding(toLength length: Int, withPad character: Character) -> String {
        let newLength = self.count

        if newLength < length {
            return String(repeatElement(character, count: length - newLength)) + self
        } else {
            return self.substring(from: index(self.startIndex, offsetBy: newLength - length))
        }
    }
}
