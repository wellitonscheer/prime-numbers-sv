module btnobouncer
(
    input  logic clk,
    input  logic rst_n,

    input  logic btn_ni,
    output logic pressed_o
);
    // pra testar no testbech so
    logic btn_deb_r;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            btn_deb_r <= 1'b0;
        else
            btn_deb_r <= btn_ni;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pressed_o <= 1'b0;
        else
            pressed_o <= btn_ni && !btn_deb_r;
    end

endmodule
