//
//  EthereumNumberFormatter.swift
//  EightBitWallet
//
//  Created by yuichiro_takahashi on 2023/05/25.
//

import BigInt
import Foundation

final class EthereumNumberFormatter {
    private static let decimalPoint = "."

    var decimalSeparator = "."
    var groupingSeparator = ","

    var minimumFractionDigits: Int = 0
    var maximumFractionDigits: Int = 0

    private let locale: Locale

    init(locale: Locale = .current) {
        self.locale = locale

        decimalSeparator = locale.decimalSeparator ?? "."
        groupingSeparator = locale.groupingSeparator ?? ","
    }

    func updateFractionDigitsConfig(digits: Int) {
        maximumFractionDigits = digits
    }

    func string(from number: BigInt, decimals: Int) -> String {
        precondition(minimumFractionDigits >= 0)
        precondition(maximumFractionDigits >= 0)

        let formatted = formatToPrecision(number.magnitude, decimals: decimals)
        switch number.sign {
        case .plus:
            return formatted
        case .minus:
            return "-" + formatted
        }
    }

    func string(from number: BigUInt, decimals: Int) -> String {
        return string(from: BigInt(number), decimals: decimals)
    }

    func bigUInt(from string: String, decimals: Int) -> BigUInt? {
        guard let index = string.firstIndex(where: { String($0) == decimalSeparator }) ?? string.firstIndex(where: { String($0) == EthereumNumberFormatter.decimalPoint }) else {
            // No fractional part
            return BigUInt(string).flatMap({ $0 * BigUInt(10).power(decimals) })
        }

        let fractionalDigits = string.distance(from: string.index(after: index), to: string.endIndex)
        if fractionalDigits > decimals {
            // Can't represent number accurately
            return nil
        }

        var fullString = string
        fullString.remove(at: index)

        guard let number = BigUInt(fullString) else {
            return nil
        }

        if fractionalDigits < decimals {
            return number * BigUInt(10).power(decimals - fractionalDigits)
        } else {
            return number
        }
    }
}

private extension EthereumNumberFormatter {
    private func formatToPrecision(_ number: BigUInt, decimals: Int) -> String {
        guard number != 0 else { return "0" }

        let divisor = BigUInt(10).power(decimals)
        let (quotient, remainder) = number.quotientAndRemainder(dividingBy: divisor)

        let remainderFormatted = fractionalString(from: remainder, quotient: quotient, decimals: decimals)
        if remainderFormatted.isEmpty {
            return integerString(from: BigInt(quotient))
        } else {
            return integerString(from: BigInt(quotient)) + decimalSeparator + remainderFormatted
        }
    }

    private func fractionalString(from remainder: BigUInt, quotient: BigUInt, decimals: Int) -> String {
        var formattingDecimals = maximumFractionDigits
        if decimals < maximumFractionDigits {
            formattingDecimals = decimals
        }
        guard formattingDecimals != 0 else { return "" }

        let fullPaddedRemainder = String(remainder).leftPadding(toLength: decimals, withPad: "0")
        var remainderPadded = fullPaddedRemainder[0 ..< formattingDecimals]

        // Remove extra zeros after the decimal point.
        if let lastNonZeroIndex = remainderPadded.reversed().firstIndex(where: { $0 != "0" })?.base {
            let numberOfZeros = remainderPadded.distance(from: remainderPadded.startIndex, to: lastNonZeroIndex)
            if numberOfZeros > minimumFractionDigits {
                let newEndIndex = remainderPadded.index(remainderPadded.startIndex, offsetBy: numberOfZeros - minimumFractionDigits)
                remainderPadded = String(remainderPadded[remainderPadded.startIndex..<newEndIndex])
            }
        }

        if remainderPadded == String(repeating: "0", count: formattingDecimals) {
            if quotient != 0 {
                return ""
            }
        }

        return remainderPadded
    }

    private func integerString(from: BigInt) -> String {
        var string = from.description
        let end = from.sign == .minus ? 1 : 0
        for offset in stride(from: string.count - 3, to: end, by: -3) {
            let index = string.index(string.startIndex, offsetBy: offset)
            string.insert(contentsOf: groupingSeparator, at: index)
        }
        return string
    }
}
