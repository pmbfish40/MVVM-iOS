//
//  BaseViewModel.swift
//  MVVM-ios
//
//  Created by Hovhannes Stepanyan on 12/10/18.
//  Copyright © 2018 Matevos Ghazaryan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum Action: Hashable {
    case openAccount
    case showBiometric
    case openErrorDialog
    case openLoginVC
    case doLogin
    case ON_NEW_IMAGE_PATH
    case showNoInternet
}

class BaseViewModel {
    private var observablesDict = [Action: Any]()
    
    public func getAction<T>(_ action: Action) -> Observable<T> {
        guard let data = observablesDict[action] else {
            let observable = PublishRelay<T>()
            observablesDict[action] = observable
            return observable.asObservable()
        }
        return (data as! PublishRelay<T>).asObservable()
    }
    
    public func doAction<T>(_ action: Action, param: T?) {
        guard let data =  observablesDict[action] else {
            let observable = PublishRelay<T?>()
            observablesDict[action] = observable
            observable.accept(param)
            return
        }
        (data as! PublishRelay<T?>).accept(param)
    }
}