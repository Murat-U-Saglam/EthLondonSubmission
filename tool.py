import random

BOARD_SIZE = 10
TOTAL_BOARD_SIZE = BOARD_SIZE * BOARD_SIZE

# Create a list with 94 zeros and 6 ones
lst = [0]*(TOTAL_BOARD_SIZE-6) + [1]*6

# Shuffle the list to distribute the ones randomly
random.shuffle(lst)

# Convert the list to a string
binary_string = ''.join(map(str, lst))

print(binary_string)