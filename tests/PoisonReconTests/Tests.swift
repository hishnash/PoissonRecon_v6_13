
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
                SIMD3([20, 1, 0, ]),
                SIMD3([20, 2, 0, ]),
                SIMD3([20, 3, 10, ]),
                SIMD3([220, 1, 0, ]),
                SIMD3([220, 2, 0, ]),
                SIMD3([220, 3, 10, ]),
                SIMD3([220, 10, 0, ]),
                SIMD3([220, 20, 0, ]),
                SIMD3([220, 30, 10, ]),
                SIMD3([220, 10, 3, ]),
                SIMD3([220, 20, 2, ]),
                SIMD3([220, 30, 3, ]),
                SIMD3([220, 10, 0, ]),
                SIMD3([220, 20, 0, ]),
                SIMD3([220, 30, 10, ]),
                SIMD3([220, 10, 3, ]),
                SIMD3([220, 20, 2, ]),
                SIMD3([220, 30, 3, ]),
            ], normals: [
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
                SIMD3([0, 1, 0 ]),
            ], scale: 10, samples_per_node: 5)
        print(v)
    }
}
