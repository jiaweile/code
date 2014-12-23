all: complex_mul

# Define Fortran compiler
FC= gfortran
#FC= g95

complex_mul: main.f90 Cuda_function.o
	$(FC) -o complex_mul main.f90 Cuda_function.o -L/home/scwangl/cuda-toolkit/cuda/lib64  -lcudart

Cuda_function.o: Cuda_function.cu
	nvcc -c -O3 Cuda_function.cu

clean: 
	rm complex_mul Cuda_function.o
