module testbench;

    logic clk = 0;
    always #10 clk = ~clk;

    logic rst_n;
    logic toggle;
    logic q;

    toggler dut (
        .clk     (clk   ),
        .rst_n   (rst_n ),
        .toggle_i(toggle),
        .q_o     (q     )
    );


    initial begin
        // Procedimento de reset
        rst_n = 0;
        toggle = 0;
        #100 rst_n = 1;

        // Imprime valor inicial
        $display("Q = %d", q);
        @(negedge clk);
        
        // Troca o valor de q
        toggle = 1;
        @(negedge clk);
        $display("T=%d   Q=%d", toggle, q);

        // Manter o toggle em 1 fica alterando o valor
        @(negedge clk);
        $display("T=%d   Q=%d", toggle, q);
        @(negedge clk);
        $display("T=%d   Q=%d", toggle, q);
        @(negedge clk);
        $display("T=%d   Q=%d", toggle, q);


        // Prova que toggle em 0 não muda valor
        toggle = 0;
        @(negedge clk);
        $display("T=%d   Q=%d", toggle, q);
        toggle = 1;
        @(negedge clk);
        $display("T=%d   Q=%d", toggle, q);
        toggle = 0;
        @(negedge clk);
        $display("T=%d   Q=%d", toggle, q);

        $finish();
    end

endmodule
