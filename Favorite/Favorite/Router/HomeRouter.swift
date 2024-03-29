//
//  HomeRouter.swift
//  The Games (iOS)
//
//  Created by iOS Dev on 11/19/21.
//

import SwiftUI
import Detail

class HomeRouter {
    func makeDetailView(gameID: Int) -> some View {
        let detailUseCase = Injection.init().provideDetail(gamedID: gameID)
        let viewModel = DetailViewModel(gameID: gameID, detailUseCase: detailUseCase)
        return DetailScreen(viewModel: viewModel)
    }
}
