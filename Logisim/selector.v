module selector (
    input  wire clk,
    input  wire reset,
    input  wire next,        // timer'dan gelen tick

    output reg [1:0] sel     // 00?1, 01?2, 10?3, 11?4
);

    always @(posedge clk) begin
        if (reset)
            sel <= 2'd0;
        else if (next)
            sel <= sel + 1'b1;
    end

endmodule
