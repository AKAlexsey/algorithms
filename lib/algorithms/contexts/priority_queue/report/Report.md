### Report

We gonna measure performance by making different input fields sizes. Increase size twice every time.

We gonna run benchmark with default params

```elixir
Benchmark.perform()
```

## First run

### Script

Run: 
10 seconds

Measure fields params: {width, height, shuffle_ratio}
[{3, 3, 20}, {3, 6, 20}, {6, 6, 20}, {6, 12, 20}, {12, 12, 20}]



Also fields was generated before. And during tests we chosen random one from array.

Field creation algorithm:

```elixir
defp initialize_test_data_v1(params, times) do
  Enum.map(params, fn {w, h, sh_ratio} ->
    fields_array = Enum.map((1..times), fn i ->
      Field.initialize(w, h)
      |> Field.shuffle(sh_ratio)
    end)
    argument_function = fn -> Enum.at(fields_array, :rand.uniform(times) - 1) end
    {w, h, sh_ratio, argument_function}
  end)
end
```

### Output

```
Estimated total run time: 1 min


Benchmarking    12x12 - ratio: 20...
Benchmarking    3x3 - ratio: 20...
Benchmarking    3x6 - ratio: 20...
Benchmarking    6x12 - ratio: 20...
Benchmarking    6x6 - ratio: 20...

Name                         ips        average  deviation         median         99th %
        3x3 - ratio: 20           88.03       11.36 ms   ±246.14%        1.86 ms       96.45 ms
        3x6 - ratio: 20           32.23       31.03 ms   ±156.64%       10.83 ms      195.81 ms
        6x6 - ratio: 20            7.33      136.41 ms   ±126.92%       24.93 ms      565.21 ms
        12x12 - ratio: 20          0.58     1737.51 ms   ±170.77%      599.41 ms     7782.97 ms
        6x12 - ratio: 20           0.30     3340.86 ms    ±83.87%     4951.61 ms     4965.65 ms

Comparison: 
        3x3 - ratio: 20           88.03
        3x6 - ratio: 20           32.23 - 2.73x slower
        6x6 - ratio: 20            7.33 - 12.01x slower
        12x12 - ratio: 20          0.58 - 152.95x slower
        6x12 - ratio: 20           0.30 - 294.09x slower
```

## Second run

First run does not have statistically valid output. Deviation is too big.
Algorithm does not works stable with same shuffle and size. But still number of iterations was too small.
So there was decided to measure more input data and more times, to reduce deviation.
Also there was decided to change field generation to random during test. Because it's rather simple and may be 
faster then taking N th element of array.

### Script

Run: 
30 seconds

Measure fields params: {width, height, shuffle_ratio}
[{3, 3, 20}, {3, 6, 20}, {6, 6, 20}, {6, 12, 20}, {12, 12, 20}]

Field generation algorithm V2:

```elixir
defp initialize_test_data_v2(params, times) do
  Enum.map(params, fn {w, h, sh_ratio} ->
    argument_function = fn -> Field.initialize(w, h) |> Field.shuffle(sh_ratio) end
    {w, h, sh_ratio, argument_function}
  end)
end
```

### Output

```
warmup: 2 s
time: 30 s
memory time: 0 μs
parallel: 1
inputs: none specified
Estimated total run time: 2.67 min


Benchmarking    12x12 - ratio: 20...
Benchmarking    3x3 - ratio: 20...
Benchmarking    3x6 - ratio: 20...
Benchmarking    6x12 - ratio: 20...
Benchmarking    6x6 - ratio: 20...

Name                         ips        average  deviation         median         99th %
        3x3 - ratio: 20           59.62       0.0168 s   ±252.96%      0.00303 s         0.21 s
        3x6 - ratio: 20            1.73         0.58 s   ±606.47%      0.00888 s        25.24 s
        6x6 - ratio: 20            0.36         2.81 s   ±301.84%       0.0392 s        31.79 s
        6x12 - ratio: 20          0.186         5.39 s   ±206.02%        0.147 s        31.58 s
        12x12 - ratio: 20        0.0313        31.91 s   ±161.91%         9.44 s       108.39 s

Comparison: 
        3x3 - ratio: 20           59.62
        3x6 - ratio: 20            1.73 - 34.41x slower
        6x6 - ratio: 20            0.36 - 167.64x slower
        6x12 - ratio: 20          0.186 - 321.40x slower
        12x12 - ratio: 20        0.0313 - 1902.30x slower
```
