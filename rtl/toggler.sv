module toggler
(
    input  logic clk,
    input  logic rst_n,

    input  logic toggle_i,
    output logic q_o
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q_o <= 1'b0;
        else if (toggle_i)
            q_o <= !q_o;
    end

endmodule
