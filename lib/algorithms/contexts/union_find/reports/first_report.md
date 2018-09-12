# First algorithm benchmark


## Operation #1

```elixir
Algorithms.UnionFind.Benchmark.perform([30, 60, 120], 10)
```

## Result #1

```
Operating System: Linux"
CPU Information: Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
Number of Available Cores: 4
Available memory: 3.76 GB
Elixir 1.6.3
Erlang 19.0

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 10 s
memory time: 0 μs
parallel: 1
inputs: none specified
Estimated total run time: 36 s


Benchmarking    120x120 grid connected...
Benchmarking    30x30 grid connected...
Benchmarking    60x60 grid connected...

Name                              ips        average  deviation         median         99th %
        30x30 grid connected         62.27 K       16.06 μs    ±71.98%          14 μs          43 μs
        60x60 grid connected         16.53 K       60.50 μs    ±50.13%          56 μs         153 μs
        120x120 grid connected        4.06 K      246.53 μs    ±53.33%         225 μs      678.16 μs

Comparison: 
        30x30 grid connected         62.27 K
        60x60 grid connected         16.53 K - 3.77x slower
        120x120 grid connected        4.06 K - 15.35x slower
```

## Operation #2

```elixir
Algorithms.UnionFind.Benchmark.perform([30, 60, 120, 240], 10)
```

## Result #2

```
Operating System: Linux"
CPU Information: Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
Number of Available Cores: 4
Available memory: 3.76 GB
Elixir 1.6.3
Erlang 19.0

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 10 s
memory time: 0 μs
parallel: 1
inputs: none specified
Estimated total run time: 48 s


Benchmarking    120x120 grid connected...
Benchmarking    240x240 grid connected...
Benchmarking    30x30 grid connected...
Benchmarking    60x60 grid connected...
Warning: The function you are trying to benchmark is super fast, making measurements more unreliable!
This holds especially true for memory measurements.
See: https://github.com/PragTob/benchee/wiki/Benchee-Warnings#fast-execution-warning

You may disable this warning by passing print: [fast_warning: false] as configuration options.


Name                              ips        average  deviation         median         99th %
        30x30 grid connected         64.80 K       15.43 μs    ±76.98%          14 μs          39 μs
        60x60 grid connected         16.31 K       61.30 μs    ±23.12%       60.40 μs       89.20 μs
        120x120 grid connected        4.12 K      242.72 μs    ±52.86%         221 μs         649 μs
        240x240 grid connected        1.03 K      974.61 μs    ±52.60%         894 μs        2556 μs

Comparison: 
        30x30 grid connected         64.80 K
        60x60 grid connected         16.31 K - 3.97x slower
        120x120 grid connected        4.12 K - 15.73x slower
        240x240 grid connected        1.03 K - 63.16x slower
```
