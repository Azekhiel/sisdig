class PerhitunganRaw:
    def __init__(self):
        self.int_out = 0
        self.float_out = 0
        self.exp_out = 0
        self.out_bin = [0] * 16

    def calculate(self, int_in, float_in, exp_in, sign_in):
        pengali = 1
        int_val = 0
        float_val = 0
        exp_val = 0

        if exp_in >= 1:
            for i in range(exp_in, 0, -1):
                pengali *= 10
            int_val = int_in * pengali + float_in * pengali // 10

        elif exp_in == 0:
            int_val = int_in
            float_val = float_in

        elif exp_in >= -5:
            int_val = 0
            pengali = 100000
            for j in range(-1 * exp_in, 0, -1):
                pengali //= 10
            float_val = int_in * pengali + float_in * pengali // 10

        self.int_out = int_val
        self.float_out = float_val
        self.exp_out = exp_val

        # Call the dectobin function to convert to binary
        self.out_bin = self.dectobin(int_val, float_val, exp_val, sign_in)

    def dectobin(self, int_val, float_val, exp_val, sign_in):
        int1 = [0] * 11
        float1 = [0] * 11
        out_signal = [0] * 22

        # Convert integer part to binary
        for i in range(11):
            int1[i] = int_val % 2
            int_val //= 2

        # Convert float part to binary
        if float_val > 0:
            while float_val < 1000000 and float_val > 0:
                float_val *= 10

            float_val *= 2
            for j in range(10, -1, -1):
                float1[j] = float_val // 1000000
                if float_val >= 1000000:
                    float_val -= 1000000

        # Combine integer and float binary parts
        out_signal = int1 + float1

        # Find the first '1' from the left
        k = out_signal[21]
        l = 21
        for l in range(21, -1, -1):
            if k == 0:
                k = out_signal[l]
            else:
                break

        exp_sementara = [0] * 5
        exp = sum(exp_sementara) + (l - 1) + 15 - 11
        mantissa = out_signal[(l - 1):(l - 10):-1]

        # Combine sign, exponent, and mantissa
        out_bin = [sign_in] + [exp] + mantissa
        return out_bin

# Example usage:
perhitungan = PerhitunganRaw()
perhitungan.calculate(int_in=5, float_in=3, exp_in=-5, sign_in=0)
print(f"int_out: {perhitungan.int_out}, float_out: {perhitungan.float_out}, exp_out: {perhitungan.exp_out}, out_bin: {perhitungan.out_bin}")
