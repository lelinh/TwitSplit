//
//  ComposingViewModel.swift
//  TwitSplit
//
//  Created by LinhLe on 4/9/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import RxSwift

enum ErrorList:String {
    case tooLong = "message too long!!!"
    case containWordMoreThan50Characters = "The message contain a span of non-whitespace characters longer than 50 characters!!"
    case unknown = "Unknown error!!"
}

enum SplitResult {
    case success
    case failure
    case error
}

class ComposingViewModel: BaseViewModel {
    let failureSubject = PublishSubject<Failure>()
    
    func split(message: String) -> [String] {
        var result:[String] = []
        if splitWithOneMessage(message: message, result: &result) != .failure {        }
        else if splitWithUnderTenMessages(message: message, result: &result) != .failure {        }
        else if splitWithUnderHundredMessage(message: message, result: &result) != .failure {        }
        else {
            _ = splitError(result: &result, errorMessage: ErrorList.tooLong.rawValue)
        }
        for item in result {
            print(item)
        }
        for item in result {
            print(item.count)
        }
        return result
    }
    
    func splitWithOneMessage(message: String, result: inout [String]) -> SplitResult {
        result = []
        if message.count < 50 {
            result.append(message)
            return .success
        } else {
            return .failure
        }
    }
    
    func splitWithUnderTenMessages(message: String, result: inout [String]) -> SplitResult {
        var messageText = " " + message
        result = []
        if message.count >= 10*47 {
            return .failure
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
                    return splitError(result: &result, errorMessage: ErrorList.containWordMoreThan50Characters.rawValue)
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
    
    func splitWithUnderHundredMessage(message: String, result: inout [String]) -> SplitResult{
        var messageText = " " + message
        var counter = 0
        result = []
        if message.count >= (9*46 + 90*45) {
            return splitError(result: &result, errorMessage: ErrorList.tooLong.rawValue)
        }
        if message.count < 50 {
            result.append(message)
            return .success
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
                            return splitError(result: &result, errorMessage: ErrorList.containWordMoreThan50Characters.rawValue)
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
                            return splitError(result: &result, errorMessage: ErrorList.containWordMoreThan50Characters.rawValue)
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
    
    func splitFailure(result: inout [String]) -> SplitResult {
        result = []
        return .failure
    }
    
    func splitError(result: inout [String],errorMessage: String) -> SplitResult {
        result = []
        failureSubject.onNext(Failure(message: errorMessage))
        return .error
    }
    
    func splitSuccess(result: inout [String]) -> SplitResult {
        addPartIndicator(messages: &result)
        return .success
    }
    
    func isFirstWordTooLong(text: String) -> Bool {
        if !(text.suffix(text.count - 1)).contains(" ") {
            return true
        }else{
            return false
        }
    }
    
    func addPartIndicator(messages: inout [String]) {
        let messages_ = messages
        messages = []
        if messages_.count < 10 {
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
    }
}
