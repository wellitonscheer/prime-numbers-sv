// module usuario (
//     input logic clk,
//     input logic rst_n,

//     input logic inc_i,
//     input logic dec_i,
//     input logic start_i,
//     input logic valid_o,
//     output logic en_i,
//     output logic data_i,

//     output logic teste_btn
// );
//     logic incre_pres;
//     button btn_incrementar (
//         .clk(clk),
//         .rst_n(rst_n),
//         .btn_ni(inc_i),
//         .pressed_o(incre_pres)
//     );

//     logic incrementar;
//     toggler tgl_i (
//         .clk(clk),
//         .rst_n(rst_n),
//         .toggle_i(incre_pres),
//         .q_o(incrementar)
//     );
//     assign teste_btn = incrementar;

//     logic decre_pres;
//     button btn_decrementar (
//         .clk(clk),
//         .rst_n(rst_n),
//         .btn_ni(dec_i),
//         .pressed_o(decre_pres)
//     );

//     logic decrementar;
//     toggler tgl_d (
//         .clk(clk),
//         .rst_n(rst_n),
//         .toggle_i(decre_pres),
//         .q_o(decrementar)
//     );

//     logic statrut_pres;
//     button btn_start (
//         .clk(clk),
//         .rst_n(rst_n),
//         .btn_ni(start_i),
//         .pressed_o(statrut_pres)
//     );

//     logic start;
//     toggler tgl_s (
//         .clk(clk),
//         .rst_n(rst_n),
//         .toggle_i(statrut_pres),
//         .q_o(start)
//     );

//     logic s_start;
//     always_ff @(posedge clk or negedge rst_n) begin
//         if (!rst_n)
//             s_start <= 1;
//         else
//             s_start <= start;
//     end

//     always_ff @(posedge clk or negedge rst_n) begin
//         if (!rst_n)
//             data_i <= '0;
//         else if (!incrementar)
//             data_i <= data_i + 1'b1;
//         else if (!decrementar && data_i != '0)
//             data_i <= data_i - 1'b1;
//     end

// endmodule

module usuario (
    input logic clk,
    input logic rst_n,

    input logic inc_i,
    input logic dec_i,
    input logic start_i,
    input logic visu_i,

    output logic [3:0] leds
);

    logic increase_press;
    btnobouncer btn_inc (
        .clk(clk),  
        .rst_n(rst_n),
        .btn_ni(inc_i),
        .pressed_o(increase_press)
    );

    logic decrese_press;
    btnobouncer btn_dec (
        .clk(clk),  
        .rst_n(rst_n),
        .btn_ni(dec_i),
        .pressed_o(decrese_press)
    );

    logic start_press;
    btnobouncer btn_start (
        .clk(clk),  
        .rst_n(rst_n),
        .btn_ni(start_i),
        .pressed_o(start_press)
    );

    logic prime_o;
    logic valid_o;
    logic [3:0] data_i;
    prime prime_uud (
        .clk(clk),
        .rst_n(rst_n),
        .en_i(start_press),
        .data_i(data_i),
        .prime_o(prime_o),
        .valid_o(valid_o)
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            data_i <= 4'b0010;
        else if (!valid_o)
            data_i <= data_i;
        else if (increase_press && data_i < '1)
            data_i <= data_i + 1;
        else if (decrese_press && data_i > 4'b0010)
            data_i <= data_i - 1;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            leds <= 4'b1111;
        else if (!visu_i) begin
            if (prime_o)
                leds <= 4'b1110;
            else
                leds <= 4'b1111;
        end
        else
            leds <= ~data_i;
    end

endmodule