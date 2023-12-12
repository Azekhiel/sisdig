def bin_to_float(bin_str):
    # Check if the binary string is 28 bits
    if len(bin_str) != 16:
        return "Error: Input must be a 28-bit binary string"

    # Extract the sign, exponent, and mantissa from the binary string
    sign_bit = int(bin_str[0], 2)
    exponent_bits = int(bin_str[1:6], 2)
    mantissa_bits = bin_str[6:]

    # Calculate the value of the exponent
    exponent = exponent_bits - 15

    # Calculate the value of the mantissa
    mantissa = 1 + sum([int(bit) * 2**(-i) for i, bit in enumerate(mantissa_bits, start=1)])

    # Calculate the final result
    result = ((-1)**sign_bit) * mantissa * (2**exponent)

    return result

bin_str = "0001110000000000"
print(bin_to_float(bin_str))
