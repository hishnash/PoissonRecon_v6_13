
import XCTest
@testable import PoisonRecon

final class Tests: XCTestCase {
    func testRunWith3Points() {
        let (f, v) = try! PoisonRecon.poisson_reconstruction(
            points: [
                SIMD3([0, 0, 0, ]),
                SIMD3([10, 0, 0, ]),
                SIMD3([10, 0, 10, ]),
                SIMD3([20, 0, 0, ]),
                SIMD3([20, 0, 0, ]),
                SIMD3([20, 0, 10, ]),
            ], normals: [
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
            ], scale: 100, samples_per_node: 5)
        print(f)
    }
}
