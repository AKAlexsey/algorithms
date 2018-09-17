## Benchmarking

I have intentionally written bad algorithm. And compare it to algorithm with good structure.
Results speaks by themselves.
Algorithms performed on same data, generated randomly.
There are two parameters of generated data: {points_count, collinear_points_ratio}
Default input data is [{10, 0.5}, {20, 0.5}, {40, 0.5}, {80, 0.5}, {80, 0.1}] respectively

### Command

```elixir
Algorithms.Sorting.Benchmark.perform()
```

### Command output

```
Name                               ips        average  deviation         median         99th %
         10 p.   0.5 fast sort         2992.72        0.33 ms    ±23.64%        0.31 ms        0.68 ms
         20 p.   0.5 fast sort          546.22        1.83 ms    ±37.72%        1.44 ms        3.78 ms
         10 p.   0.5 brute force        238.25        4.20 ms    ±18.60%        3.96 ms        7.95 ms
         40 p.   0.5 fast sort          149.61        6.68 ms    ±23.37%        5.92 ms       11.87 ms
         80 p.   0.5 fast sort           37.47       26.69 ms     ±6.07%       26.59 ms       32.65 ms
         80 p.   0.1 fast sort           37.19       26.89 ms     ±9.09%       26.47 ms       39.22 ms
         20 p.   0.5 brute force         10.37       96.42 ms     ±6.19%       93.28 ms      109.05 ms
         40 p.   0.5 brute force          0.40     2535.13 ms    ±15.03%     2664.49 ms     2830.91 ms
         80 p.   0.5 brute force        0.0284    35229.95 ms     ±0.00%    35229.95 ms    35229.95 ms
         80 p.   0.1 brute force        0.0275    36418.62 ms     ±0.00%    36418.62 ms    36418.62 ms

Comparison: 
         10 p.   0.5 fast sort         2992.72
         20 p.   0.5 fast sort          546.22 - 5.48x slower
         10 p.   0.5 brute force        238.25 - 12.56x slower
         40 p.   0.5 fast sort          149.61 - 20.00x slower
         80 p.   0.5 fast sort           37.47 - 79.87x slower
         80 p.   0.1 fast sort           37.19 - 80.46x slower
         20 p.   0.5 brute force         10.37 - 288.56x slower
         40 p.   0.5 brute force          0.40 - 7586.91x slower
         80 p.   0.5 brute force        0.0284 - 105433.24x slower
         80 p.   0.1 brute force        0.0275 - 108990.61x slower
```

### Conclusion

As we see. Sorting algorithm on the same data is much faster than brute force.
Also algorithm efficiency does not depends from ratio. It depends only from points number.

Now let's calculate growing time:

We increased size twice every step. So order of growth calculated by :math.log2(Growth).
It's power of growth. For example it Growth = 8 order of growth is :math.log2(8) = 3 => O(n^3) 

For brute force:
((238.25 / 10.37) + (10.37 / 0.40) + (0.40 / 0.0284) + (0.40 / 0.0275)) / 4 = 19.38
So it's mean than order of growth :math.log2(19.38) => ~O(n^4.28)

For fast sort:
((2992.72 / 546.22) + (546.22 / 149.61) + (149.61 / 37.47) + (149.61 / 37.19)) / 4 = 4.286
So it's mean than order of growth log(4.286, 2) => ~O(n^2.1)

As expected complexity of brute force algorithm has much worst performance characteristics.
As Robert Sedgewick said: "Better algorithms is better than better hardware"

Q.E.D.
