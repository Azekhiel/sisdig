function ascii_to_binary(input_char: character) return std_logic_vector is
begin
    case input_char is
        when '0' =>
            return "00110000";
        when '1' =>
            return "00110001";
        when '2' =>
            return "00110010";
        when '3' =>
            return "00110011";
        when '4' =>
            return "00110100";
        when '5' =>
            return "00110101";
        when '6' =>
            return "00110110";
        when '7' =>
            return "00110111";
        when '8' =>
            return "00111000";
        when '9' =>
            return "00111001";
        when 'A' | 'a' =>
            return "01000001";
        when 'B' | 'b' =>
            return "01000010";
        when 'C' | 'c' =>
            return "01000011";
        when 'D' | 'd' =>
            return "01000100";
        when 'E' | 'e' =>
            return "01000101";
        when 'F' | 'f' =>
            return "01000110";
        when 'G' | 'g' =>
            return "01000111";
        when 'H' | 'h' =>
            return "01001000";
        when 'I' | 'i' =>
            return "01001001";
        when 'J' | 'j' =>
            return "01001010";
        when 'K' | 'k' =>
            return "01001011";
        when 'L' | 'l' =>
            return "01001100";
        when 'M' | 'm' =>
            return "01001101";
        when 'N' | 'n' =>
            return "01001110";
        when 'O' | 'o' =>
            return "01001111";
        when 'P' | 'p' =>
            return "01010000";
        when 'Q' | 'q' =>
            return "01010001";
        when 'R' | 'r' =>
            return "01010010";
        when 'S' | 's' =>
            return "01010011";
        when 'T' | 't' =>
            return "01010100";
        when 'U' | 'u' =>
            return "01010101";
        when 'V' | 'v' =>
            return "01010110";
        when 'W' | 'w' =>
            return "01010111";
        when 'X' | 'x' =>
            return "01011000";
        when 'Y' | 'y' =>
            return "01011001";
        when 'Z' | 'z' =>
            return "01011010";
        when ' ' =>
            return "00100000";
        when '.' =>
            return "00101110";
        when ',' =>
            return "00101100";
        when ';' =>
            return "00111011";
        when ':' =>
            return "00111010";
        when '(' =>
            return "00101000";
        when ')' =>
            return "00101001";
        when '[' =>
            return "01011011";
        when ']' =>
            return "01011101";
        when '{' =>
            return "01111011";
        when '}' =>
            return "01111101";
        when '<' =>
            return "00111100";
        when '>' =>
            return "00111110";
        when '/' =>
            return "00101111";
        when '?' =>
            return "00111111";
        when '!' =>
            return "00100001";
        when '@' =>
            return "01000000";
        when '#' =>
            return "00100011";
        when '$' =>
            return "00100100";
        when '^' =>
            return "01011110";
        when '&' =>
            return "00100110";
        when '*' =>
            return "00101010";
        when '+' =>
            return "00101011";
        when '-' =>
            return "00101101";
        when '_' =>
            return "01011111";
        when '=' =>
            return "00111101";
        when '|' =>
            return "01111100";
        when '\\' =>
            return "01011100";
        when '~' =>
            return "01111110";
        when '`' =>
            return "01100000";
        when ''' =>
            return "00100111";
        when others =>
            return "00000000";
    end case;
end function;