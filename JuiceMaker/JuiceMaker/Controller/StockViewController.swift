//
//  stockViewController.swift
//  JuiceMaker
//
//  Created by unchain, kiwi on 2022/05/02.
//

import UIKit

final class StockViewController: UIViewController {
    
    @IBOutlet weak var strawberryStockLable: UILabel!
    @IBOutlet weak var bananaStockLable: UILabel!
    @IBOutlet weak var pineappleStockLable: UILabel!
    @IBOutlet weak var kiwiStockLable: UILabel!
    @IBOutlet weak var mangoStockLable: UILabel!
    
    @IBOutlet weak var strawberryStepper: UIStepper!
    @IBOutlet weak var bananaStepper: UIStepper!
    @IBOutlet weak var pineappleStepper: UIStepper!
    @IBOutlet weak var kiwiStepper: UIStepper!
    @IBOutlet weak var mangoStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupStepper()
    }
    
    @IBAction private func didTapClosedBarButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction private func didTapStepper(_ sender: UIStepper) {
        do {
            let fruit = try findFruit(stepper: sender)
            changeStock(fruit: fruit)
        } catch FruitStoreError.wrongFruit {
            print("없는 과일입니다")
        } catch {
            print("")
        }
    }
    
    private func setupViews() {
        strawberryStockLable.text = showFruitsStock(name: .strawberry)
        bananaStockLable.text = showFruitsStock(name: .banana)
        pineappleStockLable.text = showFruitsStock(name: .pineapple)
        kiwiStockLable.text = showFruitsStock(name: .kiwi)
        mangoStockLable.text = showFruitsStock(name: .mango)
    }
    
    private func showFruitsStock(name: Fruit) -> String {
        return String(FruitStore.shared.showFruitsStock(name: name))
    }
    
    private func findFruit(stepper: UIStepper) throws -> Fruit {
        switch stepper {
        case strawberryStepper:
            return .strawberry
        case bananaStepper:
            return .banana
        case pineappleStepper:
            return .pineapple
        case kiwiStepper:
            return .kiwi
        case mangoStepper:
            return .mango
        default:
            throw FruitStoreError.wrongMenu
        }
    }
    
    private func findFruitStepper(fruit: Fruit) -> UIStepper {
        switch fruit {
        case .strawberry:
            return strawberryStepper
        case .banana:
            return bananaStepper
        case .pineapple:
            return pineappleStepper
        case .kiwi:
            return kiwiStepper
        case .mango:
            return mangoStepper
        }
    }
    
    private func setupStepper() {
        strawberryStepper.value = Double(FruitStore.shared.showFruitsStock(name: .strawberry))
        bananaStepper.value = Double(FruitStore.shared.showFruitsStock(name: .banana))
        pineappleStepper.value = Double(FruitStore.shared.showFruitsStock(name: .pineapple))
        kiwiStepper.value = Double(FruitStore.shared.showFruitsStock(name: .kiwi))
        mangoStepper.value = Double(FruitStore.shared.showFruitsStock(name: .mango))
    }
    
    private func selectFruitLable(fruit: Fruit) -> UILabel {
        switch fruit {
        case .strawberry:
            return strawberryStockLable
        case .mango:
            return mangoStockLable
        case .kiwi:
            return kiwiStockLable
        case .pineapple:
            return pineappleStockLable
        case .banana:
            return bananaStockLable
        }
    }
    
    private func changeStock(fruit: Fruit) {
        FruitStore.shared.changeStock(fruit: fruit, newValue: Int(findFruitStepper(fruit: fruit).value))
        selectFruitLable(fruit: fruit).text = showFruitsStock(name: fruit)
    }
}
