module usuario (
    input logic clk,
    input logic rst_n,

    input logic inc_i,
    input logic dec_i,
    input logic start_i,
    input logic valid_o,
    output logic en_i,
    output logic data_i,

    output logic teste_btn
);
    logic incre_pres;
    button btn_incrementar (
        .clk(clk),
        .rst_n(rst_n),
        .btn_ni(inc_i),
        .pressed_o(incre_pres)
    );

    logic incrementar;
    toggler tgl_i (
        .clk(clk),
        .rst_n(rst_n),
        .toggle_i(incre_pres),
        .q_o(incrementar)
    );
    assign teste_btn = incrementar;

    logic decre_pres;
    button btn_decrementar (
        .clk(clk),
        .rst_n(rst_n),
        .btn_ni(dec_i),
        .pressed_o(decre_pres)
    );

    logic decrementar;
    toggler tgl_d (
        .clk(clk),
        .rst_n(rst_n),
        .toggle_i(decre_pres),
        .q_o(decrementar)
    );

    logic statrut_pres;
    button btn_start (
        .clk(clk),
        .rst_n(rst_n),
        .btn_ni(start_i),
        .pressed_o(statrut_pres)
    );

    logic start;
    toggler tgl_s (
        .clk(clk),
        .rst_n(rst_n),
        .toggle_i(statrut_pres),
        .q_o(start)
    );

    logic s_start;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            s_start <= 1;
        else
            s_start <= start;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            data_i <= '0;
        else if (!incrementar)
            data_i <= data_i + 1'b1;
        else if (!decrementar && data_i != '0)
            data_i <= data_i - 1'b1;
    end

endmodule