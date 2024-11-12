module button
(
    input  logic clk,
    input  logic rst_n,

    input  logic btn_ni,
    output logic pressed_o
);

    // Sincronizador: passa por dois flip-flops
    logic btn_nr;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            btn_nr <= 1'b1;
        else
            btn_nr <= btn_ni;
    end

    logic btn_nr2;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            btn_nr2 <= 1'b1;
        else
            btn_nr2 <= btn_nr;
    end

    // Nega o segundo flip-flop para trabalhar com lógica active-high
    logic btn;
    assign btn = !btn_nr2;

    // Debouncer: ignora mudanças no botão durante um breve intervalo de tempo
    logic [21:0] counter;   /* 2^22 * 20 ns = 83.88 ms */

    logic btn_deb;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            btn_deb <= 1'b0;
        else if (counter == '0)
            btn_deb <= btn;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= '0;
        end
        else begin
            if (counter != '0)
                counter <= counter - 1'b1;
            else if (btn_deb != btn)
                counter <= '1;
        end
    end

    // Converte para um único pulso no clique
    logic btn_deb_r;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            btn_deb_r <= 1'b0;
        else
            btn_deb_r <= btn_deb;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pressed_o <= 1'b0;
        else
            pressed_o <= btn_deb && !btn_deb_r;
    end

endmodule
