#  Collinear points
Current exercise is programming task of week 3 course of "Algorithms Pt.1" Robert Sedgewick

## Description
There is some field with random number of random points. 
You must find all those four inline.

To do it:
1. Create Point model;
2. Make function slope; 

```elixir
@spec slope(%Point{}, %Point{}) :: float | :infinity
```

Those show angle of slope between two points.
4. Initialize field with random points and several four inline.
5. Make slope from one point to all another. 

And here is two solutions:

A - Brute force:

6. Take each three and check if their slopes are equal. If so - they three and first point are equal.

So it's complexity will be n^4

B - Fast:

6. Sort all slopes. So all collinear will be near.

7. Repeat for each combination in set.
