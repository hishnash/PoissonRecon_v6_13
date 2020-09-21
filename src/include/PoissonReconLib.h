#ifndef PoissonReconLib_h
#define PoissonReconLib_h

#pragma once
#import <stdlib.h>
#ifdef __cplusplus
#include <vector>
extern std::vector<double> double_data;
extern std::vector<int> int_data;
extern std::vector<double> mem_data;
extern bool* is_verbose;
extern "C" {

#endif
int PoissonReconLibMain(int argc, char* argv[]);
void clear_int_data();
void clear_double_data();
void clear_mem_data();
void resize_mem_data(size_t size);
void set_mem_data(size_t index, double value);

size_t int_data_size();
size_t double_data_size();
int* int_data_ptr();
double* double_data_ptr();

#ifdef __cplusplus
}
#endif

#endif /* PoissonReconLib_h */
