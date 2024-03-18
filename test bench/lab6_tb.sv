module d_ff_tb();
    logic clk = 0;
    logic reset = 0;
    logic write = 0;
    logic [3:0] num;
    logic [2:0] sel;
    logic [7:0] anode;
    logic [6:0] cathode;
    SevenSegmentDisplay DUT (
        .clk(clk),
        .reset(reset),
        .write(write),
        .num(num),
        .sel(sel),
        .anode(anode),
        .cathode(cathode)
    );
    always #5 clk = ~clk;
    initial begin
        reset = 1;
        #10;
        reset = 0;
    end
    initial begin
        #20;
        write = 1;
        num = 4'b0000; sel = 3'b000; #10;
        num = 4'b0001; sel = 3'b001; #10;
        num = 4'b0010; sel = 3'b010; #10;
        num = 4'b0011; sel = 3'b011; #10;
        num = 4'b0100; sel = 3'b100; #10;
        num = 4'b0101; sel = 3'b101; #10;
        num = 4'b0110; sel = 3'b110; #10;
        num = 4'b0111; sel = 3'b111; #10;

        write = 0;
        #100;
        $stop;  // Stop simulation
    end
endmodule

