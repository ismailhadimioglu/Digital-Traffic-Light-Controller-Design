module timer (
    input  wire clk,
    input  wire reset,
    input  wire enable,

    output reg tick
);

    parameter MAX_COUNT = 10;   // sim için küçük

    reg [$clog2(MAX_COUNT):0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            tick  <= 0;
        end else if (enable) begin
            if (count == MAX_COUNT) begin
                count <= 0;
                tick  <= 1'b1;
            end else begin
                count <= count + 1'b1;
                tick  <= 1'b0;
            end
        end else begin
            tick <= 0;
        end
    end

endmodule
