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

        when ' ' =>
            return "00100000";
        when '.' =>
            return "00101110";
        when ',' =>
            return "00101100";

        when '*' =>
            return "00101010";
        when '+' =>
            return "00101011";
        when '-' =>
            return "00101101";
        when ':' =>
            return "00111010";
            
        when 'E' | 'e' =>
            return "01000101";

        when others =>
            return "00000000";
    end case;
end function;