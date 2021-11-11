//
//  MainViewConfigurator.swift
//  CarRentalsApp
//
//  Created by Sonali Kalange on 10/11/21.
//

import Foundation

protocol MainViewConfiguratorImpl {
    func bindElementsFor(viewController: ViewController)
}

class MainViewConfigurator: MainViewConfiguratorImpl {
    func bindElementsFor(viewController: ViewController) {
        let carDetailsUseCase = CarDetailsUseCase()
        viewController.viewModel = MainViewModel(useCase: carDetailsUseCase)
    }
}
