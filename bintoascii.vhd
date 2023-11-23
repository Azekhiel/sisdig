function bintoascii(input_char: character) return std_logic_vector is
begin
    case input_char is
        when '00110000' =>
            return "0";
        when '00110001' =>
            return "1";
        when '00110010' =>
            return "2";
        when '00110011' =>
            return "3";
        when '00110100' =>
            return "4";
        when '00110101' =>
            return "5";
        when '00110110' =>
            return "6";
        when '00110111' =>
            return "7";
        when '00111000' =>
            return "8";
        when '00111001' =>
            return "9";
        when 'E'  =>
            return "1000101";
        when 'e' =>
            return "1100101";
        when '00100000' =>
            return " ";
        when '00101110' =>
            return ".";
        when '00101100' =>
            return ",";
        when '00111011' =>
            return ";";
        when '00111010' =>
            return ":";
        when '00101000' =>
            return "(";
        when '00101001' =>
            return ")";
        when '01011011' =>
            return "[";
        when '01011101' =>
            return "]";
        when '01111011' =>
            return "{";
        when '01111101' =>
            return "}";
        when '00111100' =>
            return "<";
        when '00111110' =>
            return ">";
        when '00101111' =>
            return "/";
        when '00111111' =>
            return "?";
        when '00100001' =>
            return "!";
        when '01000000' =>
            return "@";
        when '00100011' =>
            return "#";
        when '01011110' =>
            return "^";
        when '00100110' =>
            return "";
        when '00101010' =>
            return "*";
        when '00101011' =>
            return "+";
        when '00101101' =>
            return "-";
        when '01011111' =>
            return "_";
        when '00111101' =>
            return "=";
        when '|' =>
            return "01111100";
        when '01011100' =>
            return "\\";
        when '01111110' =>
            return "~";
        when '01100000' =>
            return "`";
        when '00100111' =>
            return "'";
        when others =>
            return "null";
    end case;
end function;   