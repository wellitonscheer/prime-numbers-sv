// module prime (
//     input logic clk,
//     input logic rst_n,

//     input logic inc_i,
//     input logic dec_i,
//     input logic start_i,

//     output logic [3:0] leds,
//     output logic teste_btn
// );
//     logic valid_o;
//     logic en_i;
//     logic [3:0] data_i;

//     usuario us (
//         .clk(clk),
//         .rst_n(rst_n),
//         .inc_i(inc_i),
//         .dec_i(dec_i),
//         .start_i(start_i),
//         .valid_o(valid_o),
//         .en_i(en_i),
//         .data_i(data_i),
//         .teste_btn(teste_btn)
//     );

//     always_ff @(posedge clk or negedge rst_n) begin 
//         if (!rst_n)
//             leds <= '1;
//         else
//             leds <= data_i;
//     end
    
// endmodule

module prime (
    input logic clk,
    input logic rst_n,

    input logic en_i,
    input logic [3:0] data_i,

    output logic prime_o,
    output logic valid_o
);
    // No testbanch wait(valid_o == 1); ai sabe se o calculo terminou e mostra as entradas e saidas

    // Aguardar uma entrada [IDLE] (ficar sem fazer nada) até que tenha sinal de en_i
    // quando entrada, computar o resto da divisao (%) [COMPUTE]
        // se o resto da divisao for 0, nao é primo, pode sair do estado do calculo
        // Se o divisor for igual ao numero de teste, pode sair do estado de calculo (é primo)
    // Se nao for primo, atualizar as saidas [NOT_PRIME]
    // Se for primo, atualizar as saidas [PRIME]

    typedef enum logic [3:0] { 
        IDLE = 4'b0001,
        COMPUTE = 4'b0010,
        PRIME = 4'b0100,
        NOT_PRIME = 4'b1000
    } state_t;

    state_t estado_atual;
    state_t proximo_estado;

    logic [3:0] i;
    // Fazer a lógica de controlar o i (é um always_ff)
        // O que acontece com ele no estado IDLE?
        // O que acontece com ele no estado COMPUTE?
    
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            i <= 4'b0010;
        case (estado_atual)
            IDLE: i <= 4'b0010;
            COMPUTE: i <= i + 1;
            default: i <= i;
        endcase
    end

    always_comb begin
        case (estado_atual)
            IDLE: proximo_estado = en_i ? COMPUTE : IDLE;
            COMPUTE: begin
                if (data_i == i)
                    proximo_estado = PRIME;
                else if (data_i % i == '0)
                    proximo_estado = NOT_PRIME;
                else
                    proximo_estado = COMPUTE;
            end
            PRIME: proximo_estado = IDLE;
            NOT_PRIME: proximo_estado = IDLE;
            default: proximo_estado = IDLE;
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            estado_atual <= IDLE;
        else
            estado_atual <= proximo_estado;
    end

    // Exemplo: data_i = 7
        // 7 % 2 = 1
        // 7 % 3 = 1
        // 7 % 4 = 3
        // 7 % 5 = 2
        // 7 % 6 = 1
        // 7 % 7 = 0 --> 7 == 7 é primo
    
    // Exemplo: data_i = 9
        // 9 % 2 = 1
        // 9 % 3 = 0 --> 9 != 3 não é primo

    // always_ff que atualiza o valid_o
        // quando ele fica invalido? --> depende das entradas e do estado_atual
        // quando ele fica valido? --> depende do estatdo_atual
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            valid_o <= 1;
        else
            if (estado_atual == COMPUTE)
                valid_o <= 0;
            else
                valid_o <= 1;
    end
    
    // always_ff que atualiza o prime_o
        // Quando ele é prime? --> Depende do estado_atual
        // Quando ele não é prime? --> Depende do estado_atual
 
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            prime_o <= 0;
        else
            if (estado_atual == PRIME)
                prime_o <= 1;
            else if (estado_atual == NOT_PRIME)
                prime_o <= 0;
            else
                prime_o <= prime_o;
    end
    
endmodule