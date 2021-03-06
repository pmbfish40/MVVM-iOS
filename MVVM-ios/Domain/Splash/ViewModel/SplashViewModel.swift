//
//  SplashViewModel.swift
//  MVVM-ios
//
//  Created by Hovhannes Stepanyan on 11/7/18.
//  Copyright © 2018 Matevos Ghazaryan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SplashViewModel: BaseViewModel {
    
    private(set) var configs: BehaviorRelay<Configs?>
    private(set) var user: PublishRelay<User?>
    private(set) var disposeBag: DisposeBag
    
    required init() {
        disposeBag = DisposeBag()
        configs = BehaviorRelay(value: nil)
        user = PublishRelay()
    }
    
    override func retry() {
        getConfigs()
    }
    
    func getConfigs() {
        DataRepository.api().getConfigs().take(1)
            .subscribe(onNext: {
                self.configs.accept($0)
                self.toNextVC()
            }, onError: {
                self.doAction(BaseAction.openErrorDialog, param: $0)
            }, onDisposed: {
                print("\(self) disposed")
            })
            .disposed(by: disposeBag)
    }
    
    func toNextVC() {
        if DataRepository.preference().getRememberMe() && BiometricUtils.biometricType() != .none {
            self.doAction(Action.showBiometric, param: Optional<User>(nilLiteral: ()))
        } else {
            self.doAction(Action.openLoginVC, param: Optional<User>(nilLiteral: ()))
        }
    }
    
    func login() {
        guard let email = DataRepository.keychain().getEmail(),
            let password = DataRepository.keychain().getPassword() else {
                self.doAction(BaseAction.openErrorDialog, param: Optional<Error>(nilLiteral: ()))
                return
        }
        DataRepository.api().login(email: email, password: password)
            .subscribe(onNext: {
                self.doAction(Action.openAccount, param: $0)
            }, onError: {
                self.doAction(BaseAction.openErrorDialog, param: $0)
            })
            .disposed(by: disposeBag)
    }
}
