import Combine

check("Empty", publisher: Empty<Int, SampleError>())

check("Just", publisher: Just("Hello SwiftUI").map{$0 + "hahahah"})


check("Publishers.Sequence", publisher: [1, 2, 3].publisher.map{$0*2})

check("Publishers.Sequence", publisher: [1, 2, 3].publisher.reduce(0, +))

extension Sequence {
    func scan<ResultElement>(_ initial: ResultElement, _ nextPartialResult:(ResultElement, Element) -> ResultElement) -> [ResultElement] {
        var result: [ResultElement] = []
        for x in self {
            result.append(nextPartialResult(result.last ?? initial, x))
        }
        return result
    }
}

check("Publishers.Sequence", publisher: [1, 2, 3].publisher.scan(0, +))

