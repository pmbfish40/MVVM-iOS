//
//  APIHelperProtocol.swift
//  MVVM-ios
//
//  Created by Hovhannes Stepanyan on 11/7/18.
//  Copyright © 2018 Matevos Ghazaryan. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol APIHelperProtocol {
    associatedtype MoyaTarget: TargetType
    
    var apiProvider: MoyaProvider<MoyaTarget> { get set }
    
    func getConfigs() -> Observable<Configs?>
    func login(email: String, password: String) -> Observable<User?>
    func logOut() -> Observable<Void>
    func getTransactions(page: Int) -> Observable<TransactionData>
    func getCards() -> Observable<[Card]>
    func uploadImage(_ data: Data) -> Observable<ProgressResponse>
}
