module syncmemory(IN_DATA, OUT_DATA, ADDR, RD, WR, CLK, RST);
	parameter data_width = 32;
	parameter depth = 256;
	parameter address_width = 8;
	parameter input_file = "d:/Work/dissertation_microprocessor/altera_projects/filter/lol.bin";
	parameter output_file = "d:/Work/dissertation_microprocessor/altera_projects/filter/lolo.bin";
	input [data_width-1:0] IN_DATA;
	input [address_width-1:0] ADDR;
	output reg [data_width-1:0] OUT_DATA;
	input WR;
	input RD;
	input CLK;
	input RST;
	
	integer file;
  integer return_value;

	reg [data_width-1:0] mem [depth-1:0];

	initial begin
		file = $fopen(input_file, "rb");
		return_value = $fread( mem, file); 
		$fclose(file);
	end 

	always @(posedge CLK) begin
		if(RST == 1) begin
			OUT_DATA = 0;
		end else if(WR == 1) begin
			mem[ADDR] = IN_DATA;
			file = $fopen(output_file, "w");
			$fwriteb(file, "%p", mem);
			$fclose(file);
		end else if(RD == 1) begin
			OUT_DATA = mem[ADDR];
		end
	end
endmodule

module syncmemory_tb();
	//IN_DATA, OUT_DATA, ADDR, RD, WR, CLK, RST
	parameter data_width = 32;
	parameter depth = 256;
	parameter address_width = 8;
	parameter input_file = "d:/Work/dissertation_microprocessor/altera_projects/filter/lol.bin";
	parameter output_file = "d:/Work/dissertation_microprocessor/altera_projects/filter/lolo.bin";
	
	reg [data_width-1:0] rIN_DATA;
	wire [data_width-1:0] IN_DATA;
	reg [address_width-1:0] rADDR;
	wire [address_width-1:0] ADDR;
	reg rCLK;
	wire CLK;
	reg rRD;
	wire RD;
	reg rWR;
	wire WR;
	reg rRST;
	wire RST;
	wire [data_width-1:0] OUT_DATA;
	
	assign IN_DATA = rIN_DATA;
	assign ADDR = rADDR;
	assign CLK = rCLK;
	assign RD = rRD;
	assign WR = rWR;
	assign RST = rRST;
	
	syncmemory mem1(IN_DATA, OUT_DATA, ADDR, RD, WR, CLK, RST);
	defparam mem1.data_width = data_width;
	defparam mem1.depth = depth;
	defparam mem1.address_width = address_width;
	defparam mem1.input_file = input_file;
	defparam mem1.output_file = output_file;
	
	always begin
		#5 rCLK = ~rCLK;
	end
	
	initial begin
		rADDR = 3;
		rIN_DATA = 10;
		rCLK = 0;
		rRD = 0;
		rWR = 0;
		#5 rWR = 1;
		#5 rWR = 0;
		#5 rRD = 1;
		#5 rADDR = 4;
	end
endmodule
