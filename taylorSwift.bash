#!/bin/bash

# Compile Swift code
swiftc -o TaylorSwift taylor.swift

# Run the compiled Swift program
./TaylorSwift

# Assuming the Swift program has successfully written the data to /tmp/actual.dat and /tmp/approximation.dat
# Now prepare the Gnuplot commands
gnuplotCommands=$(cat <<EOF
set terminal png size 800,600
set output '/tmp/taylor_series_approximation.png'
set title "e^x and its Taylor Series Approximation"
set xlabel "x"
set ylabel "y"
plot "/tmp/actual.dat" with lines title "Actual e^x", "/tmp/approximation.dat" with lines title "Taylor Approximation"
EOF
)

# Execute the Gnuplot commands
echo "$gnuplotCommands" | gnuplot

# Notify the user
echo "Plot generated at /tmp/taylor_series_approximation.png"
