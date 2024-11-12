module usuario_tb;

    logic clk = 0;
    always #10 clk = ~clk;

    logic rst_n;

    logic inc_i;
    logic dec_i;
    logic start_i;

    logic [3:0] leds;

    usuario usuario_uud (
        .clk(clk),
        .rst_n(rst_n),
        .inc_i(inc_i),
        .dec_i(dec_i),
        .start_i(start_i),
        .leds(leds)
    );

    initial begin
        // Procedimento de reset
        rst_n = 0; // pressionado
        inc_i = 0; // nao pressionado
        dec_i = 0; // nao pressionado
        start_i = 0; // nao pressionado
        #100
        rst_n = 1; // nao pressionado
        #50

        $display("leds tem q ser tudo 1 ('1) tudo desligado");
        $display("Leds=%b", leds);
        
        inc_i = 1;
        @(negedge clk);
        inc_i = 0;
        start_i = 1;
        @(leds) // espera os leds mudar

        $display("leds tem q ser 0 no ultimo (1110) (led liga com 0)");
        $display("Leds=%b", leds);

        #60

        $finish();
    end
    
endmodule