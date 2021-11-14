import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//check("Empty", publisher: Empty<Int, SampleError>())
//
//check("Just", Just("Hello SwiftUI"))
//
//
//check("Publishers.Sequence", publisher: [1, 2, 3].publisher.map{$0*2})
//
//check("Publishers.Sequence", publisher: [1, 2, 3].publisher.reduce(0, +))
//
//extension Sequence {
//    func scan<ResultElement>(_ initial: ResultElement, _ nextPartialResult:(ResultElement, Element) -> ResultElement) -> [ResultElement] {
//        var result: [ResultElement] = []
//        for x in self {
//            result.append(nextPartialResult(result.last ?? initial, x))
//        }
//        return result
//    }
//}
//
//check("Publishers.Sequence", publisher: [1, 2, 3].publisher.scan(0, +))
//

//check("timer", [1: "A", 3 : "C"].timerPublisher.merge(with: [2: "B", 4 : "D"].timerPublisher))

//func test() -> PassthroughSubject<Int, Never> {
//    let subj = PassthroughSubject<Int, Never>()
//
//    check("subj", subj)
//    subj.send(100)
//    delay(1, on: .global()) {
//        print("11111")
//        subj.send(1)
//        delay(1) {
//            subj.send(2)
//            delay(1) {
//                subj.send(completion: .finished)
//            }
//        }
//    }
//    return subj
//}
//
//let ttt = check("test", test())


//let subject1 = PassthroughSubject<Int, Never>()
//let subject2 = PassthroughSubject<String, Never>()
//check("Zip", publisher: subject1.zip(subject2))
//
//subject1.send(1)
//subject2.send("A")
//subject1.send(2)
//subject2.send("B")
//subject2.send("C")
//subject2.send("D")
//subject1.send(3)
//subject1.send(4)
//subject1.send(5)
struct Response: Decodable {
    struct Args: Decodable {
        let foo: String
    }
    let args: Args?
}
//
//let timer = Timer.publish(every: 1, on: .main, in: .default)
//let ct = check("Timer", timer)
//timer.connect()
//
//let url = URL(string: "https://httpbin.org/get?foo=bar")!
//let a = URLSession
//    .shared
//    .dataTaskPublisher(for: url)
//    .sink { completion in
//        switch completion {
//        case .finished:
//            print("finished")
//        case .failure(let error):
//            print(error)
//        }
//    } receiveValue: { value in
//        print(value)
//    }

//let timer =

let searachText = PassthroughSubject<String, Never>()

func demoDataTaskPublisher(param: String) -> URLSession.DataTaskPublisher {
    var urlcpnt = URLComponents(string: "https://httpbin.org/")!
    urlcpnt.path = "/get"
    urlcpnt.queryItems = [URLQueryItem(name: "foo", value: param)]
    return URLSession.shared.dataTaskPublisher(for: urlcpnt.url!)
}

let searchCheck = check("search",
                        searachText
                            .throttle(for: 1.0, scheduler: RunLoop.main, latest: true)
//                            .scan("", +)
//                            .flatMap{ demoDataTaskPublisher(param: $0) }
//                            .map{ data, response in data }
//                            .decode(type: Response.self, decoder: JSONDecoder())
//                            .map{ $0.args!.foo }
)


delay(0.1) { searachText.send("I") }
delay(0.2) { searachText.send("Love") }
delay(0.5) { searachText.send("SwiftUI") }
delay(1.6) { searachText.send("And") }
delay(1.9) { searachText.send("Combine") }

//URLSession.shared
//    .dataTaskPublisher(for: URL(string: "https://httpbin.org/get?foo=bar")!).delay(for: 1, scheduler: ImmediateScheduler.shared)
