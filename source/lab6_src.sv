module SevenSegmentDisplay(
    input logic [3:0] num,
    input logic [2:0] sel,
    input logic clk, reset, write,
    output logic [7:0] anode,
    output logic [6:0] cathode
);

    // Internal array to hold values for each digit
    logic [3:0] digit_values[0:7];

    // Counter variable for loop
    integer i;

    // Main logic block
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            // Reset all digit values to 0
            for(i = 0; i < 8; i++) begin
                digit_values[i] <= 4'b0000;
            end
        end
        else begin
            if (write) begin
                // Write the input number to selected digit
                case(sel)
                    3'b000: digit_values[0] <= num;
                    3'b001: digit_values[1] <= num;
                    3'b010: digit_values[2] <= num;
                    3'b011: digit_values[3] <= num;
                    3'b100: digit_values[4] <= num;
                    3'b101: digit_values[5] <= num;
                    3'b110: digit_values[6] <= num;
                    3'b111: digit_values[7] <= num;
                endcase
            end
            else begin
                // Display the selected digit based on array_sel
                case(sel)
                    3'b000: begin 
                        anode <= 8'b11111110;
                        cathode <= get_cathode_value(digit_values[0]);
                    end
                    3'b001: begin 
                        anode <= 8'b11111101;
                        cathode <= get_cathode_value(digit_values[1]);
                    end
                    3'b010: begin 
                        anode <= 8'b11111011;
                        cathode <= get_cathode_value(digit_values[2]);
                    end
                    3'b011: begin 
                        anode <= 8'b11110111;
                        cathode <= get_cathode_value(digit_values[3]);
                    end 
                    3'b100: begin 
                        anode <= 8'b11101111;
                        cathode <= get_cathode_value(digit_values[4]);
                    end
                    3'b101: begin 
                        anode <= 8'b11011111;
                        cathode <= get_cathode_value(digit_values[5]);
                    end 
                    3'b110: begin 
                        anode <= 8'b10111111;
                        cathode <= get_cathode_value(digit_values[6]);
                    end
                    3'b111: begin 
                        anode <= 8'b01111111;
                        cathode <= get_cathode_value(digit_values[7]);
                    end
                endcase
            end
        end
    end

    // Function to get the cathode value based on input digit
    function logic [6:0] get_cathode_value;
        input logic [3:0] digit;
        begin
            case(digit)
                4'b0000: get_cathode_value = 7'b0000001;
                4'b0001: get_cathode_value = 7'b1001111;
                4'b0010: get_cathode_value = 7'b0010010;
                4'b0011: get_cathode_value = 7'b0000110;
                4'b0100: get_cathode_value = 7'b1001100;
                4'b0101: get_cathode_value = 7'b0100100;
                4'b0110: get_cathode_value = 7'b0100000;
                4'b0111: get_cathode_value = 7'b0001111;
                4'b1000: get_cathode_value = 7'b0000000;
                4'b1001: get_cathode_value = 7'b0000100;
                4'b1010: get_cathode_value = 7'b0001000;
                4'b1011: get_cathode_value = 7'b1100000;
                4'b1100: get_cathode_value = 7'b0110001;
                4'b1101: get_cathode_value = 7'b1000010;
                4'b1110: get_cathode_value = 7'b0110000;
                4'b1111: get_cathode_value = 7'b0111000;
                default: get_cathode_value = 7'b0000000;
            endcase
        end
    endfunction

endmodule
