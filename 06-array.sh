#!/bin/bash

#indes starts from 0, size is 3
FRUITS=("APPLE" "KIWI" "MANGO")

echo "First Fruit is: ${FRUITS[0]}"
echo "Second Fruit is: ${FRUITS[1]}"
echo "third Fruit is: ${FRUITS[2]}"

echo "First Fruit is: ${FRUITS[@]}"