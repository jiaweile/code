#include <stdio.h>
#include <assert.h>
#include <cuda.h>
#include <sys/time.h>

#define N 10240000
#define ThreadPerBlock 128
#define NSTREAM 4

__global__ void multiply(double * a, double *b , double * output, int length)
{
	int tid = blockIdx.x * blockDim.x + threadIdx.x;
	
	if(tid < length)
		output[tid] = a[tid] + b[tid];
}

int main()
{	
	cudaSetDevice(1);
	int nbytes = N * sizeof (double);
	double *a, *b, *c;
	double *dev_A, *dev_B, *dev_C;
	a = (double *) malloc( N*sizeof(double));
	b = (double *) malloc( N*sizeof(double));
	c = (double *) malloc( N*sizeof(double));
	if(a == NULL){
		printf("Error malloc \n");
		exit(0);
	}
	int i; 
	for (i = 0; i < N ; i++)
	{
		a[i] = i;
		b[i] = i;
	}
	
	assert(cudaMalloc((void**) &dev_A, nbytes) == cudaSuccess);
	assert(cudaMalloc((void**) &dev_B, nbytes) == cudaSuccess);
	assert(cudaMalloc((void**) &dev_C, nbytes) == cudaSuccess);
	
	assert(cudaMemcpy(dev_A, a, nbytes, cudaMemcpyHostToDevice) == cudaSuccess);
	assert(cudaMemcpy(dev_B, b, nbytes, cudaMemcpyHostToDevice) == cudaSuccess);
	
	struct timeval begin, end;
	gettimeofday(&begin, NULL);
	
	int nblock = N/ThreadPerBlock;
	if ( N % ThreadPerBlock) nblock ++;
	multiply<<<nblock, ThreadPerBlock>>>(dev_A, dev_B, dev_C,N);
	assert( cudaThreadSynchronize()  == cudaSuccess ) ;
	
	gettimeofday(&end, NULL);
	double time = 1000000*(end.tv_sec - begin.tv_sec) + (end.tv_usec - begin.tv_usec);
	printf("One Stream time: %lf ms \n", time);
	
	cudaStream_t stream[NSTREAM];
	
	int n = N/NSTREAM;
	printf("%d\n", n);
	assert( cudaThreadSynchronize()  == cudaSuccess ) ;
	
	gettimeofday(&begin, NULL);
	for (i = 0; i < NSTREAM; i++)
	{
		nblock = n/ThreadPerBlock;
		if(n % ThreadPerBlock) nblock++;
		assert(cudaStreamCreate(&stream[i])== cudaSuccess);
		multiply<<<nblock, ThreadPerBlock, 0, stream[i]>>>(&dev_A[i*n], &dev_B[i*n], &dev_C[i*n], n);
		assert(cudaStreamDestroy(stream[i])== cudaSuccess);
	}
	assert( cudaThreadSynchronize()  == cudaSuccess ) ;
	
	gettimeofday(&end, NULL);
	time = 1000000*(end.tv_sec - begin.tv_sec) + (end.tv_usec - begin.tv_usec);
	printf("%d Stream time: %lf ms \n",NSTREAM, time);

	assert(cudaMemcpy(c, dev_C, nbytes, cudaMemcpyDeviceToHost) == cudaSuccess);

	for (i = 0; i < N; i++)
	{
		int d = (int) c[i];
		int e = 2*i;
		if( d != e)
		{
			printf("Error, %d, %lf\n", i, c[i]);
			exit(0);
		}
	}
	printf("Passed!!\n");
	cudaFree(dev_A);
	cudaFree(dev_B);
	cudaFree(dev_C);
	
	free(a);
	free(b);
	free(c);
}

	
