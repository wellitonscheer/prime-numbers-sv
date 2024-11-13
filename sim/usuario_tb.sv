module usuario_tb;

    logic clk = 0;
    always #10 clk = ~clk;

    logic rst_n;

    logic inc_i = 1;
    logic dec_i = 1;
    logic start_i = 1;
    logic visu_i = 1;

    logic [3:0] leds;

    usuario usuario_uud (
        .clk(clk),
        .rst_n(rst_n),
        .inc_i(inc_i),
        .dec_i(dec_i),
        .start_i(start_i),
        .visu_i(visu_i),
        .leds(leds)
    );

    initial begin
        // Procedimento de reset
        rst_n = 0; // pressionado
        repeat (10) @(posedge clk);
        rst_n = 1; // nao pressionado
        @(negedge clk)

        $display("leds tem q ser b0010 (b1101) tudo desligado");
        $display("Leds=%b", leds);
        
        inc_i = 0; // pressionado
        repeat (5) @(posedge clk);
        inc_i = 1;

        start_i = 0; // pressionado
        repeat (5) @(posedge clk);
        start_i = 1;
        repeat (5) @(posedge clk);
        visu_i = 0;
        repeat (2) @(posedge clk);

        $display("leds tem q ser 0 no ultimo (1110) (led liga com 0)");
        $display("Leds=%b", leds);

        repeat (2) @(posedge clk);
        visu_i = 1;

        repeat (5) @(posedge clk);

        inc_i = 0; // pressionado
        repeat (5) @(posedge clk);
        inc_i = 1;

        start_i = 0; // pressionado
        repeat (5) @(posedge clk);
        start_i = 1;

        $display("leds tem ser valor 2 (0010) invertido fica (1101) (led liga com 0)");
        $display("Leds=%b", leds);

        repeat (5) @(posedge clk);

        dec_i = 0; // pressionado
        repeat (5) @(posedge clk);
        dec_i = 1;

        start_i = 0; // pressionado
        repeat (5) @(posedge clk);
        start_i = 1;

        $display("leds tem ser valor 1 (0001) inverte (1110) (led liga com 0)");
        $display("Leds=%b", leds);

        repeat (20) @(posedge clk);
        $finish();
    end
    
endmodule