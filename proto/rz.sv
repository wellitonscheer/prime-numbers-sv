module rz
(
    input  logic clk,
    input  logic rst_n,

    input  logic btn_ni,
    output logic led_no
);

    // Converte o clique no botão para um único pulso em pressed
    // Não precisa negar o botão para ligar ao módulo button
    logic pressed;
    button btn_m (
        .clk(clk),  
        .rst_n(rst_n),
        .btn_ni(btn_ni),
        .pressed_o(pressed)
    );

    // Módulo que chaveia o valor de q quando recebe pulso em toggle_i
    logic q;
    toggler tgl (
        .clk(clk),
        .rst_n(rst_n),
        .toggle_i(pressed),
        .q_o(q)
    );

    // Inverte o q para mostrar no LED
    assign led_no = ~q;

endmodule
