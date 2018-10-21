# Benchmarking

## Brute force algorithm implementation measurement

I have implemented brute force algorithm implementation. 
All tests has been performed for increasing points number count.
Number of points is 10, 20, 40, 80, 160 ... to measure algorithm performance.

### Insert

Benchmark output:

```
Name                                 ips        average  deviation         median         99th %
        160 p. SimplePoint insert        3.12 M        0.32 μs  ±7587.25%           0 μs           1 μs
        10 p. SimplePoint insert         1.82 M        0.55 μs   ±789.03%        0.50 μs        1.80 μs
        20 p. SimplePoint insert         1.79 M        0.56 μs   ±642.92%        0.50 μs        1.90 μs
        40 p. SimplePoint insert         1.77 M        0.56 μs    ±18.98%        0.54 μs        1.05 μs
        80 p. SimplePoint insert         1.45 M        0.69 μs   ±410.18%        0.60 μs        2.40 μs

Comparison: 
        160 p. SimplePoint insert        3.12 M
        10 p. SimplePoint insert         1.82 M - 1.71x slower
        20 p. SimplePoint insert         1.79 M - 1.74x slower
        40 p. SimplePoint insert         1.77 M - 1.76x slower
        80 p. SimplePoint insert         1.45 M - 2.14x slower
```

**Conclusion**

Rather strange measurements fastest insert is for largest number of points. 
For the rest - there is no big difference. It's mean that insert time is nearly constant. That what we expected.

## Contains  

Benchmark output: 

```
Name                                     ips        average  deviation         median         99th %
        10 p. SimplePoint contains         765.72 K        1.31 μs  ±2548.05%           1 μs           2 μs
        20 p. SimplePoint contains         413.32 K        2.42 μs  ±1263.63%           2 μs           4 μs
        40 p. SimplePoint contains         248.14 K        4.03 μs   ±617.70%           3 μs           8 μs
        80 p. SimplePoint contains         121.09 K        8.26 μs   ±224.28%           7 μs          16 μs
        160 p. SimplePoint contains         62.12 K       16.10 μs    ±86.78%          14 μs          31 μs
        320 p. SimplePoint contains         31.45 K       31.80 μs    ±38.24%          28 μs          60 μs
        640 p. SimplePoint contains         15.88 K       62.96 μs    ±27.87%          57 μs         116 μs
        1280 p. SimplePoint contains         7.94 K      126.03 μs    ±26.05%         114 μs         237 μs
        2560 p. SimplePoint contains         3.99 K      250.97 μs    ±25.55%         227 μs         480 μs
        5120 p. SimplePoint contains         1.95 K      513.65 μs    ±25.67%         457 μs         951 μs 
        10240 p. SimplePoint contains        0.96 K     1038.99 μs    ±21.48%         961 μs        1858 μs

Comparison: 
        10 p. SimplePoint contains         765.72 K
        20 p. SimplePoint contains         413.32 K - 1.85x slower
        40 p. SimplePoint contains         248.14 K - 3.09x slower
        80 p. SimplePoint contains         121.09 K - 6.32x slower
        160 p. SimplePoint contains         62.12 K - 12.33x slower
        320 p. SimplePoint contains         31.45 K - 24.35x slower
        640 p. SimplePoint contains         15.88 K - 48.21x slower
        1280 p. SimplePoint contains         7.94 K - 96.50x slower
        2560 p. SimplePoint contains         3.99 K - 192.18x slower
        5120 p. SimplePoint contains         1.95 K - 393.31x slower
        10240 p. SimplePoint contains        0.96 K - 795.58x slower
```

**Conclusion**

Contains function is linear. Double argument make function value approximately double.

## Nearest 

Code:

```
Benchmark.perform([10, 20, 40, 80, 160, 320, 640], :nearest)
```

Benchmark output: 

```
Name                                  ips        average  deviation         median         99th %
        10 p. SimplePoint nearest        16.15 K       61.91 μs    ±34.15%          60 μs         142 μs
        20 p. SimplePoint nearest         6.64 K      150.60 μs    ±22.95%         143 μs         301 μs
        40 p. SimplePoint nearest         3.09 K      323.40 μs    ±20.97%         306 μs      620.34 μs
        80 p. SimplePoint nearest         1.41 K      710.54 μs    ±18.99%         673 μs     1298.26 μs
        160 p. SimplePoint nearest        0.69 K     1449.53 μs    ±16.90%        1378 μs        2414 μs
        320 p. SimplePoint nearest        0.34 K     2929.59 μs    ±14.62%        2808 μs     4387.88 μs
        640 p. SimplePoint nearest       0.168 K     5947.78 μs    ±12.86%        5718 μs     7996.26 μs

Comparison: 
        10 p. SimplePoint nearest        16.15 K
        20 p. SimplePoint nearest         6.64 K - 2.43x slower
        40 p. SimplePoint nearest         3.09 K - 5.22x slower
        80 p. SimplePoint nearest         1.41 K - 11.48x slower
        160 p. SimplePoint nearest        0.69 K - 23.41x slower
        320 p. SimplePoint nearest        0.34 K - 47.32x slower
        640 p. SimplePoint nearest       0.168 K - 96.07x slower
```

**Conclusion**

Nearest function is linear. Double argument make function value approximately double.

## Range  

Code:

```
Benchmark.perform([10, 20, 40, 80, 160, 320, 640, 1280, 2560, 5120], :range)
```

Benchmark output: 

```
Name                                 ips        average  deviation         median         99th %
        10 p. SimplePoint range        731.17 K        1.37 μs  ±1920.91%           1 μs           3 μs
        20 p. SimplePoint range        483.36 K        2.07 μs  ±1313.46%           2 μs           4 μs
        40 p. SimplePoint range        307.17 K        3.26 μs   ±832.92%           3 μs           7 μs
        80 p. SimplePoint range        177.31 K        5.64 μs   ±256.56%           5 μs          18 μs
        160 p. SimplePoint range        92.56 K       10.80 μs   ±119.91%          10 μs          31 μs
        320 p. SimplePoint range        46.82 K       21.36 μs    ±66.88%          18 μs          64 μs
        640 p. SimplePoint range        20.08 K       49.79 μs    ±85.19%          38 μs         230 μs
        1280 p. SimplePoint range        4.93 K      202.69 μs   ±166.30%          85 μs        1710 μs
        2560 p. SimplePoint range        1.43 K      699.50 μs   ±197.12%         224 μs     7142.08 μs
        5120 p. SimplePoint range        0.62 K     1614.83 μs   ±209.88%         452 μs    16815.76 μs

Comparison: 
        10 p. SimplePoint range        731.17 K
        20 p. SimplePoint range        483.36 K - 1.51x slower
        40 p. SimplePoint range        307.17 K - 2.38x slower
        80 p. SimplePoint range        177.31 K - 4.12x slower
        160 p. SimplePoint range        92.56 K - 7.90x slower
        320 p. SimplePoint range        46.82 K - 15.62x slower
        640 p. SimplePoint range        20.08 K - 36.40x slower
        1280 p. SimplePoint range        4.93 K - 148.20x slower
        2560 p. SimplePoint range        1.43 K - 511.45x slower
        5120 p. SimplePoint range        0.62 K - 1180.71x slower
```

**Conclusion**

Range function growth function is logarithmic. It's equation is _0.47 + 0.1075 * ln x_

## KD Tree algorithm implementation measurement

I have implemented algorithm using KD Trees. 
All tests has been performed for increasing points number count.
Number of points is 10, 20, 40, 80, 160 ... to measure algorithm performance.
It must make growth is logarithmic. Check it.

### Insert

Benchmark output:

```
```

## Contains  

Benchmark output: 

```
```

**Conclusion**



## Nearest 

Code:

```
```

Benchmark output: 

```
```

**Conclusion**


## Range  

Code:

```
```

Benchmark output: 

```
```

**Conclusion**

