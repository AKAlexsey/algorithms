## Second algorithm benchmark

Code has been refactored. Field logic moved to UnionFind.Field module
Benchmark also has been refactored. So i run test for ensure nothing has been broken.


### Command #1

```elixir
Benchmark.test1([30, 60, 120, 240])
```

### Command output

```
Name                              ips        average  deviation         median         99th %
        30x30 grid connected         43.35 K       23.07 μs    ±87.18%          20 μs          68 μs
        60x60 grid connected         11.26 K       88.83 μs    ±62.85%          76 μs         266 μs
        120x120 grid connected        2.70 K      370.99 μs    ±70.69%         303 μs        1324 μs
        240x240 grid connected        0.72 K     1393.85 μs    ±66.25%        1157 μs     4581.50 μs

Comparison: 
        30x30 grid connected         43.35 K
        60x60 grid connected         11.26 K - 3.85x slower
        120x120 grid connected        2.70 K - 16.08x slower
        240x240 grid connected        0.72 K - 60.43x slower
```

### Command #2

I have made optimization. Balancing trees. In case of union trees we link small tree under large tree.
It allow us to reduce number of array access during finding root. As a consequence connected must run faster.
Presumably in sqrt(2) times. Because this optimization moved connected? operation from N complexity to lg N complexity

```
Benchmark.test2([30, 60, 120, 240], 30)
```

### Command output

```
Name                              ips        average  deviation         median         99th %
        30x30 grid connected         63.33 K       15.79 μs   ±119.35%          15 μs          34 μs
        60x60 grid connected         16.54 K       60.46 μs    ±45.95%          58 μs         134 μs
        120x120 grid connected        4.22 K      237.24 μs    ±45.49%         227 μs         535 μs
        240x240 grid connected        1.05 K      948.97 μs    ±45.46%         909 μs     2124.60 μs

Comparison: 
        30x30 grid connected         63.33 K
        60x60 grid connected         16.54 K - 3.83x slower
        120x120 grid connected        4.22 K - 15.02x slower
        240x240 grid connected        1.05 K - 60.09x slower
```

### Conclusion

To calculate optimization we must find average ratio between IPS before and after optimization.
(1.05 / 0.72 + 4.22 / 2.7 + 16.54 / 11.26 + 63.33 / 43.35) / 4 = 1.49
:math.sqrt 2 = 1.4142135623730951

So we have made optimization. And acceleration value is 1.49 as we presumed.
Q.E.D.
