import RxSwift
import PlaygroundSupport
import Foundation
PlaygroundPage.current.needsIndefiniteExecution = true

let disposeBag = DisposeBag()

struct Product {
    var price: Variable<Double>
}

let appleWatch = Product(price: Variable(1299.99))
let iPad = Product(price: Variable(999.99))

let appleProductsSubject = PublishSubject<Product>()

appleProductsSubject.subscribe(onNext: {
    print($0.price.value)
})

// Better way
appleProductsSubject
    .flatMap {
        $0.price.asObservable()
    }
    .subscribe(onNext: {
        print("Product price: $\($0)")
    })
    .addDisposableTo(disposeBag)

appleProductsSubject.onNext(appleWatch)
appleProductsSubject.onNext(iPad)


