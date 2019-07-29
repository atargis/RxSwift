import RxSwift
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let disposeBag = DisposeBag() // Memory management

let numberSequence = Observable.just(6)

let numberSubscription = numberSequence.subscribe(onNext: {
    print($0)
}).addDisposableTo(disposeBag)

let helloSeq = Observable.from(["H","e","l","l","o"])

let helloSub = helloSeq.subscribe { event in
    switch event {
    case .next(let value):
        print(value)
    case .error(let value):
        print(value)
    case .completed:
        print("Completed")
    }
}.addDisposableTo(disposeBag)

//helloSub.dispose() // free resources, but not in this way!

// Subjects

var publishSubject = PublishSubject<String>()
publishSubject.onNext("Hello")

let pubSubSubscription = publishSubject.subscribe(onNext: {
    print("First: " + $0)
})

publishSubject.onNext("Hello")
publishSubject.onNext("Again")

let pubSubscriptionTwo = publishSubject.subscribe(onNext: {
    print("Second: " + $0)
})

publishSubject.onNext("Both subscription get this message.")

// Behavior Subject

var behaviorSubject = BehaviorSubject(value: "Value 1")

let subscriptionOne = behaviorSubject.subscribe(onNext: {
    print("Subscription 1: \($0)")
})

behaviorSubject.onNext("Value 2")
behaviorSubject.onNext("Value 3")

let subscriptionTwo = behaviorSubject.subscribe(onNext: {
    print("Subscription 2: \($0)")
})

behaviorSubject.onNext("Both subscriptions")

// Replay subject

var accountSubject = ReplaySubject<Double>.create(bufferSize: 3)

var accountManager = accountSubject.subscribe(onNext: {
    print("Transaction amount: $\($0)")
})

accountSubject.onNext(8.88)
accountSubject.onNext(219.00)
accountSubject.onNext(77.15)
accountSubject.onNext(8.56)
accountSubject.onNext(4.12)
accountSubject.onNext(1005.00)

var lastThreeTrans = accountSubject.subscribe(onNext: {
        print("Last three - Transaction amounts: $\($0)")
})

// VARIABLES
var variable = Variable<String>("Hello from variable")
variable.asObservable().subscribe(onNext: {
    print($0)
})

