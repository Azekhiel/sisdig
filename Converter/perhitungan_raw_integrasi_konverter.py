def dectobin(int_in, float_in, exp_in, sign_in):
    # Convert integer part to binary
    int_bin = format(int_in, '011b')

    # Convert float part to binary
    float_bin = ''
    float_temp = float_in
    exp_temp =0

    # while float_temp < 10000 and float_temp > 0:
    #     float_temp *= 10
    #     exp_temp -=1

    for _ in range(11):
        float_temp *= 2
        bit = '1' if float_temp // 100000 == 1 else '0'
        float_bin += bit

        if float_temp >= 100000:
            float_temp -= 100000

    # Combine integer and float parts
    out_signal = int_bin + float_bin

    # Find the position of the first '1' from the left
    l=0
    for i in range (0,22):
        if out_signal[i] =="1":
            l=i
            break

    # Calculate exponent
    exp = (10-l ) + 15 

    # Extract mantissa
    if l<=11:
        mantissa = out_signal[l+1:l+11]
    else:
        mantissa = out_signal[l+1:20]
        while len(mantissa)!=10:
            mantissa =  mantissa +"0" 
            print(mantissa)

    # Construct the final binary output
    out_bin = sign_in + format(exp, '05b') + mantissa
    return out_bin

def perhitungan_raw(int_in, float_in, exp_in, sign_in):
    # Perform calculations based on the input exponent
    pengali = 1
    if exp_in >= 1:
        pengali = 10 ** exp_in
        int_out = int_in * pengali + float_in * pengali // 10
        float_out = 0
        exp_out = exp_in
    elif exp_in == 0:
        int_out = int_in
        float_out = float_in
        exp_out = exp_in
    elif exp_in >= -5:
        int_out = 0
        pengali = 100000 // (10 ** (-1*exp_in))
        float_out = int_in * pengali + float_in * pengali // 10
        exp_out = exp_in

    # Convert to binary using the dectobin function
    out_bin = dectobin(int_out, float_out, exp_out, sign_in)
    print(int_out, float_out, exp_out, sign_in)
    return out_bin

# Example usage
sign_in = '0'  # Assuming positive number for demonstration
int_in = 4
float_in = 5
exp_in = -1
print(perhitungan_raw(int_in, float_in, exp_in, sign_in))
