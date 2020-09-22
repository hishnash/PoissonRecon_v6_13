//
//  File.swift
//  
//
//  Created by Matthaus Woolard on 21/09/20.
//

import PoisonReconLib.lib


public struct PoisonRecon {
    public enum Errors: Error {
        case noFacesReturned
        case noVertitiesReturned
        case unexpectedReturnValue(Int32)
    }
    
    public static func poisson_reconstruction(
            points: [SIMD3<Float>],
            normals: [SIMD3<Float>],
            depth: Int=8,
            full_depth: Int=5,
            scale: Double=1.10,
            samples_per_node: Double=1.0,
            cg_depth: Double=0.0,
            enable_polygon_mesh: Bool=false,
            enable_density: Bool=false
    ) throws -> (faces: [SIMD3<Int64>], vertities: [SIMD3<Float>]) {
    
        defer {
            clear_int_data()
            clear_double_data()
            clear_mem_data()
        }
        
        
        let arg_depth = String(depth)
        let arg_full_depth = String(full_depth)
        let arg_scale = String(scale)
        let arg_samples_per_node = String(samples_per_node)
        let arg_cg_depth = String(cg_depth)

        // Clear data methods
        //int_data.clear()
        clear_int_data()
        //double_data.clear()
        clear_double_data()
        //mem_data.clear()
        clear_mem_data()
                

        // resize memory data to fit
        //mem_data.resize(point_ncols * point_nrows + normal_ncols * normal_nrows)
        resize_mem_data(points.count * 3 * 2)

        
        for (i, point) in points.enumerated() {
            for index in point.indices {
                // set value at index
                set_mem_data(index + i * (6), Double(point[index]))                
                set_mem_data(index + 3 + i * (6), Double(normals[i][index]))
            }
        }
//        for i in range(point_nrows):
//            for j in range(point_ncols):
//                mem_data[j +  i*(point_ncols + normal_ncols)] = points[i,j]
//                mem_data[j + point_ncols + i *(point_ncols + normal_ncols)] = normals[i,j]


        var args = [
            "PoissonRecon",
            "--in",
            "none",
            "--out",
            "none",
            "--depth",
            arg_depth,
            "--fullDepth",
            arg_full_depth,
            "--scale",
            arg_scale,
            "--samplesPerNode",
            arg_samples_per_node,
            "--cgDepth", arg_cg_depth,
            "--verbose"
        ]


        if enable_polygon_mesh {
            args += ["--polygonMesh"]
        }
            
        if enable_density {
            args += ["--density"]
        }
        
        var cargs = args.map { UnsafeMutablePointer<Int8>(strdup($0)) }
    
        defer {
            for ptr in cargs { free(UnsafeMutablePointer(mutating: ptr)) }
        }
        
        let result = PoissonReconLibMain(Int32(args.count), &cargs)
        
        guard result == 0 else { throw Errors.unexpectedReturnValue(result) }
        
        let face_rows = int_data_size() / 3
        let vertex_rows = double_data_size() / 3
        
        guard let int_data = int_data_ptr() else {
            throw Errors.noFacesReturned
        }
        guard let double_data = double_data_ptr() else {
            throw Errors.noVertitiesReturned
        }

        var faces: [SIMD3<Int64>] = []
        var vertities: [SIMD3<Float>] = []
        
        // read out the faces
        for i in 0..<face_rows {
            let face_ptr = int_data.advanced(by: i * 3)
            faces.append(
                SIMD3<Int64>(
                    Int64(face_ptr.pointee),
                    Int64(face_ptr.advanced(by: 1).pointee),
                    Int64(face_ptr.advanced(by: 2).pointee)
                )
            )
        }
        
        for i in 0..<vertex_rows {
            let vertex_ptr = double_data.advanced(by: i * 3)
            vertities.append(
                SIMD3<Float>(
                    Float(vertex_ptr.pointee),
                    Float(vertex_ptr.advanced(by: 1).pointee),
                    Float(vertex_ptr.advanced(by: 2).pointee)
                )
            )

        }
        
        return (
            faces,
            vertities
        )
    }
}
