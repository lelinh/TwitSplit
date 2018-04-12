//
//  TwitterSplitMessage.swift
//  TwitSplit
//
//  Created by LinhLe on 4/12/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import Foundation

enum SplitResult: String {
    case Success = "Success"
    case Failure = "Failure"
    
    case TooLong = "message too long!!!"
    case ContainWordMoreThan50Characters = "The message contain a span of non-whitespace characters longer than 50 characters!!"
    case Unknown = "Unknown error!!"
}

class TwitterSplitMessage {
    init() {
    }
    
    public func split(message: String, result: inout [String]) -> SplitResult {
        var returnValue:SplitResult = .Unknown
        result = []
        returnValue = splitWithOneMessage(message: message, result: &result)
        if returnValue != .Failure {
            return returnValue
        }
        returnValue = splitWithUnderTenMessages(message: message, result: &result)
        if returnValue != .Failure {
            return returnValue
        }
        returnValue = splitWithUnderHundredMessage(message: message, result: &result)
        if returnValue != .Failure {
            return returnValue
        }
        returnValue = splitError(result: &result, errorMessage: .TooLong)
        return returnValue
    }
    
    private func splitWithOneMessage(message: String, result: inout [String]) -> SplitResult {
        result = []
        if message.count <= 50 {
            result.append(message)
            return splitSuccess(result: &result)
        } else {
            return splitFailure(result: &result)
        }
    }
    
    private func splitWithUnderTenMessages(message: String, result: inout [String]) -> SplitResult {
        var messageText = " " + message
        result = []
        if message.count >= 10*47 {
            return splitFailure(result: &result)
        }
        while (messageText.count > 0)  {
            if messageText.count < 48 {
                result.append(messageText)
                messageText = ""
                break
            }else{
                let message_ = messageText
                var subString = String(messageText.prefix(48))
                if isFirstWordTooLong(text: (subString)) {
                    return splitError(result: &result, errorMessage: .ContainWordMoreThan50Characters)
                }
                if let range = subString.range(of: " ", options: .backwards) {
                    subString = String(subString[..<range.lowerBound])
                    messageText = String(message_.suffix(from: range.lowerBound))
                    result.append(String(subString))
                }
            }
        }
        if result.count < 10 {
            return splitSuccess(result: &result)
        }else{
            return splitFailure(result: &result)
        }
    }
    
    private func splitWithUnderHundredMessage(message: String, result: inout [String]) -> SplitResult {
        var messageText = " " + message
        var counter = 0
        result = []
        if message.count >= (9*46 + 90*45) {
            return splitError(result: &result, errorMessage: .TooLong)
        }
        if message.count < 50 {
            result.append(message)
        } else {
            while (messageText.count > 0)  {
                if counter < 10 {
                    if messageText.count < 47 {
                        result.append(messageText)
                        messageText = ""
                        counter = counter + 1
                        break
                    }else{
                        let message_ = messageText
                        var subString = String(messageText.prefix(47))
                        if isFirstWordTooLong(text: (subString)) {
                            return splitError(result: &result, errorMessage: .ContainWordMoreThan50Characters)
                        }
                        if let range = subString.range(of: " ", options: .backwards) {
                            subString = String(subString[..<range.lowerBound])
                            messageText = String(message_.suffix(from: range.lowerBound))
                            result.append(String(subString))
                            counter = counter + 1
                        }
                    }
                } else if counter < 100 {
                    if messageText.count < 46 {
                        result.append(messageText)
                        messageText = ""
                        counter = counter + 1
                        break
                    }else{
                        let message_ = messageText
                        var subString = String(messageText.prefix(46))
                        if isFirstWordTooLong(text: (subString)) {
                            return splitError(result: &result, errorMessage: .ContainWordMoreThan50Characters)
                        }
                        if let range = subString.range(of: " ", options: .backwards) {
                            subString = String(subString[..<range.lowerBound])
                            messageText = String(message_.suffix(from: range.lowerBound))
                            result.append(String(subString))
                            counter = counter + 1
                        }
                    }
                } else {
                    
                }
            }
        }
        if result.count < 100 {
            return splitSuccess(result: &result)
        }else{
            return splitFailure(result: &result)
        }
    }
    
    private func splitFailure(result: inout [String]) -> SplitResult {
        result = []
        return .Failure
    }
    
    private func splitError(result: inout [String],errorMessage: SplitResult) -> SplitResult {
        result = []
        return errorMessage
    }
    
    private func splitSuccess(result: inout [String]) -> SplitResult {
        addPartIndicator(messages: &result)
        return .Success
    }
    
    private func isFirstWordTooLong(text: String) -> Bool {
        if !(text.suffix(text.count - 1)).contains(" ") {
            return true
        }else{
            return false
        }
    }
    
    private func addPartIndicator(messages: inout [String]) {
        let messages_ = messages
        messages = []
        if messages_.count == 1 {
            messages = messages_
        }else if messages_.count < 10 {
            for i in 1...(messages_.count) {
                messages.append("\(i)/\(messages_.count)\(messages_[i - 1])")
            }
        } else if messages_.count < 100 {
            for i in 1...(messages_.count) {
                messages.append("\(i)/\(messages_.count)\(messages_[i - 1])")
            }
        } else {
            messages = messages_
        }
        messages.reverse()
    }
}
