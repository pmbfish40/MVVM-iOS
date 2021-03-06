//
//  CardsViewModel.swift
//  MVVM-ios
//
//  Created by Hovhannes Stepanyan on 11/15/18.
//  Copyright © 2018 Matevos Ghazaryan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CardsViewModel: BaseViewModel {
    private(set) var model: BehaviorRelay<[Card]>
    private var disposeBag = DisposeBag()
    
    required init() {
        model = BehaviorRelay(value: [])
    }
    
    func getCards() {
        showLoading.accept(true)
        DataRepository.api().getCards().subscribe(onNext: {
            self.showLoading.accept(false)
            self.model.accept($0)
        }, onDisposed: {
            print("\(self) disposed")
        })
            .disposed(by: disposeBag)
    }
    
    func cardSelected(_ card: Card) {
        let message = "You select \(card.cardNumber) card"
        doAction(Action.onCardTap, param: message)
    }
}
