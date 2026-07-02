module main (
    input  wire clk,
    input  wire reset,
    input  wire emergency,   // ambulans

    input  wire tick,        // timer'dan
    input  wire [1:0] sel,   // selector'dan

    output reg r1, a1, g1,
    output reg r2, a2, g2,
    output reg r3, a3, g3,
    output reg r4, a4, g4
);

    // ---------------------------------
    // ALT DURUMLAR
    // 0: KIRMIZI+SARI
    // 1: YE??L
    // 2: SARI
    // ---------------------------------
    reg [1:0] phase;

    // ---------------------------------
    // PHASE FSM
    // ---------------------------------
    always @(posedge clk) begin
        if (reset)
            phase <= 2'd0;
        else if (emergency)
            phase <= phase;       // ambulans ? dur
        else if (tick) begin
            if (phase == 2'd2)
                phase <= 2'd0;
            else
                phase <= phase + 1'b1;
        end
    end

    // ---------------------------------
    // OUTPUT LOGIC
    // ---------------------------------
    always @(*) begin
        // default: hepsi k?rm?z?
        r1=1; a1=0; g1=0;
        r2=1; a2=0; g2=0;
        r3=1; a3=0; g3=0;
        r4=1; a4=0; g4=0;

        if (!emergency) begin
            case (sel)
                2'd0: begin // ---- YOL 1 ----
                    case (phase)
                        2'd0: begin r1=1; a1=1; g1=0; end
                        2'd1: begin r1=0; a1=0; g1=1; end
                        2'd2: begin r1=0; a1=1; g1=0; end
                    endcase
                end

                2'd1: begin // ---- YOL 2 ----
                    case (phase)
                        2'd0: begin r2=1; a2=1; g2=0; end
                        2'd1: begin r2=0; a2=0; g2=1; end
                        2'd2: begin r2=0; a2=1; g2=0; end
                    endcase
                end

                2'd2: begin // ---- YOL 3 ----
                    case (phase)
                        2'd0: begin r3=1; a3=1; g3=0; end
                        2'd1: begin r3=0; a3=0; g3=1; end
                        2'd2: begin r3=0; a3=1; g3=0; end
                    endcase
                end

                2'd3: begin // ---- YOL 4 ----
                    case (phase)
                        2'd0: begin r4=1; a4=1; g4=0; end
                        2'd1: begin r4=0; a4=0; g4=1; end
                        2'd2: begin r4=0; a4=1; g4=0; end
                    endcase
                end
            endcase
        end
        // emergency = 1 ? hepsi k?rm?z? (default)
    end

endmodule

