module prime_tb;

    logic clk = 0;
    always #10 clk = ~clk;

    logic rst_n;

    logic en_i;
    logic [3:0] data_i;

    logic prime_o;
    logic valid_o;

    prime prime_uud (
        .clk(clk),
        .rst_n(rst_n),
        .en_i(en_i),
        .data_i(data_i),
        .prime_o(prime_o),
        .valid_o(valid_o)
    );

    initial begin
        // Procedimento de reset
        rst_n = 0; // pressionado
        en_i = 0; // nao pressionado
        data_i = 2;
        #100
        rst_n = 1; // nao pressionado
        #50
        
        en_i = 1;
        @(negedge valid_o);
        // aqui vai ter definido o proximo estado como compute
        en_i = 0;
        @(posedge valid_o);
        $display("Data: 2");
        $display("valido (1) e prime (1) porq 2 e prime");
        $display("Valid=%d   Prime=%d", valid_o, prime_o);

        #60

        $display("valido (1) (not compute) e not prime (0) (porq ta em idle)");
        $display("Valid=%d   Prime=%d", valid_o, prime_o);

        data_i = 3;
        en_i = 1;
        @(negedge valid_o);
        en_i = 0;
        @(posedge valid_o);
        $display("Data: 3");
        $display("valido (1) (not compute) e prime (1) 3 e prime");
        $display("Valid=%d   Prime=%d", valid_o, prime_o);

        #60

        data_i = 6;
        en_i = 1;
        @(negedge valid_o);
        en_i = 0;
        @(posedge valid_o);
        $display("Data: 6");
        $display("valido (1) (not compute) e prime (0) 6 nao e prime");
        $display("Valid=%d   Prime=%d", valid_o, prime_o);

        #60

        data_i = 13;
        en_i = 1;
        @(negedge valid_o);
        en_i = 0;
        @(posedge valid_o);
        $display("Data: 13");
        $display("valido (1) (not compute) e prime (1) 13 e prime");
        $display("Valid=%d   Prime=%d", valid_o, prime_o);

        #60

        $finish();
    end
    
endmodule