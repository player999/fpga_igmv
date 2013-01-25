module rowmult(OUT_DATA, ST, RD, CLK, RST, DATA1, DATA2, ADDR, Read);
	parameter matrix_width = 128;
	parameter data_width = 32;
	parameter address_width = 8;
	
	input ST;
	input CLK;
	input RST;
	output RD;
	output [data_width-1:0] OUT_DATA;
	input [data_width-1:0] DATA1;
	input [data_width-1:0] DATA2;
	output Read;
	output [address_width-1:0] ADDR;
	
	wire [data_width + 32 - 1:0] FOR_OUT;
	reg [data_width + 32 - 1:0] FOR_IN;
	
	assign OUT_DATA = FOR_OUT[data_width + 32 - 1:32];
	
	reg BS;
	wire BR;
	reg [1:0] state;
	
	for_statement multiply(FOR_IN, FOR_OUT, RD, ST, CLK, RST, DATA1, DATA2, ADDR, Read);
	defparam multiply.cycles = matrix_width;
	defparam multiply.mem_dw = data_width;
	defparam multiply.address_width = address_width;
	
	always @(posedge CLK) begin
		if(RST == 1) begin
			FOR_IN = 0;
			state = 0;
		end
		
	end
	
endmodule

module for_statement(IN_DATA, OUT_DATA, RD, ST, CLK, RST, DATA1, DATA2, ADDR, Read);
parameter address_width = 8;
parameter mem_dw = 32;
parameter cycles = 128;
parameter in_w = 32 + mem_dw;
parameter out_w = 32 + mem_dw;
parameter int_in_w = 32 + mem_dw;
parameter int_out_w = 32 + mem_dw;

input [in_w-1:0] IN_DATA;
output reg [out_w-1:0] OUT_DATA;
reg [out_w-1:0] DATA;
input CLK;
output reg RD;
input ST;
input RST;

input [mem_dw-1:0] DATA1;
input [mem_dw-1:0] DATA2;
output [address_width -1:0] ADDR;
output Read;

reg [1:0] state;
reg BS;
wire TST;
wire TST1;
wire BR;
wire [in_w-1:0] INIT_DATA;
wire [out_w-1:0] BODY_DATA;

for_init init_module(IN_DATA, INIT_DATA);
for_body body_module(DATA, BODY_DATA, BR, BS, CLK, RST, DATA1, DATA2, ADDR, Read);
for_test test_module(BODY_DATA, TST);
for_test test_module1(INIT_DATA, TST1);

defparam test_module.cycles = cycles;
defparam test_module1.cycles = cycles;
defparam test_module.out_w = out_w;
defparam test_module1.out_w = out_w;
defparam body_module.mem_dw = mem_dw;
defparam body_module.address_width = address_width;
defparam init_module.in_w = in_w;

   always @(posedge CLK) begin
          if(RST == 1) begin
                 state = 0;
                 OUT_DATA = 0;
                 RD = 1;
          end

          case(state)
                  0: begin
                    BS = 0;
                    RD = 1;
                    if(ST == 1) begin
                      DATA = INIT_DATA;
                      state = 1;
                    end
                  end
                  1: begin
                    BS = 0;
                    RD = 0;
                    if(TST1 == 1) begin
                      state = 2;
                      BS = 1;
                    end else begin
                      state = 0;
                      OUT_DATA = INIT_DATA;
                    end                
                  end
                  2: begin
                    BS = 1;
                    RD = 0;
                    if(BR == 1) begin
                      state = 3;
                      DATA = BODY_DATA;
                    end
                  end
                  3: begin
                    BS = 0;
                    RD = 0;
                    if(TST == 1) begin
                      state = 2;
                      BS = 0;
                    end else begin
                      state = 0;
                      OUT_DATA = DATA;
                    end
                  end
                  default: begin
                     state = 0;
                  end
          endcase
   end
endmodule

module for_body(IN_DATA, OUT_DATA, RD, ST, CLK, RST, DATA1, DATA2, ADDR, Read);
	parameter address_width = 8;
	parameter mem_dw = 32;
	parameter in_w = 32 + mem_dw;
	parameter out_w = 32 + mem_dw;
	input [in_w-1:0] IN_DATA;
	output [out_w-1:0] OUT_DATA;
	input CLK;
	output RD;
	input ST;
	input RST;

	input [mem_dw-1:0] DATA1;
	input [mem_dw-1:0] DATA2;
	output [address_width -1:0] ADDR;
	output Read;
	
	assign RD = 1;
	assign ADDR = IN_DATA[31:0];
	assign Read = 1;
	assign OUT_DATA[31:0] = IN_DATA[31:0] + 1;
	assign OUT_DATA[63:32] = IN_DATA[63:32] + DATA1 * DATA2;
endmodule

module for_init(IN_DATA, OUT_DATA);
  parameter in_w = 64;
  input [in_w-1:0] IN_DATA;
  output[in_w-1:0] OUT_DATA;
  assign OUT_DATA = IN_DATA;
endmodule

module for_test(BODY_DATA, TST);
  parameter out_w = 64;
  parameter cycles = 128;
  input [out_w-1:0] BODY_DATA;
  output TST;
  assign TST = BODY_DATA[32-1:0] < cycles;
endmodule

module rowmult_tb();
	parameter data_width = 32;
	parameter depth = 256;
	parameter address_width = 8;
	parameter input_file1 = "d:/Work/dissertation_microprocessor/altera_projects/fpga_igmv/M1.bin";
	parameter input_file2 = "d:/Work/dissertation_microprocessor/altera_projects/fpga_igmv/M2.bin";
	parameter output_file1 = "d:/Work/dissertation_microprocessor/altera_projects/fpga_igmv/MO2.bin";
	parameter output_file2 = "d:/Work/dissertation_microprocessor/altera_projects/fpga_igmv/MO2.bin";
	
	wire [data_width-1:0] OUT_DATA;
	wire [address_width-1:0] ADDR;
	wire [data_width-1:0] DATA1;
	wire [data_width-1:0] DATA2;
	wire Read;
	reg rCLK;
	wire CLK;
	reg rRST;
	wire RST;
	reg rWR;
	wire WR;
	reg rST;
	wire ST;
	wire [31:0] IN_DATA;
	assign CLK = rCLK;
	assign RST = rRST;
	assign WR = rWR;
	assign ST = rST;
	
	syncmemory mem1(IN_DATA, DATA1, ADDR, Read, WR, CLK, RST);
	defparam mem1.data_width = data_width;
	defparam mem1.depth = depth;
	defparam mem1.address_width = address_width;
	defparam mem1.input_file = input_file1;
	defparam mem1.output_file = output_file1;
	
	syncmemory mem2(IN_DATA, DATA2, ADDR, Read, WR, CLK, RST);
	defparam mem2.data_width = data_width;
	defparam mem2.depth = depth;
	defparam mem2.address_width = address_width;
	defparam mem2.input_file = input_file2;
	defparam mem2.output_file = output_file2;
	
	rowmult rowmult1(OUT_DATA, ST, RD, CLK, RST, DATA1, DATA2, ADDR, Read);
	defparam rowmult1.matrix_width = 10+1;
	
	always begin
		#5 rCLK = ~rCLK;
	end
	
	initial begin
		rCLK = 0;
		rST = 0;
		rWR = 0;
		rRST = 0;
		#5 rRST = 1;
		#5 rRST = 0;
		#5 rST = 1;
		#5 rST = 0;
	end
	
endmodule
