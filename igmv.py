#IGMV generator
import math
#begin Settings
MATRIX_ROWS = 10;
MATRIX_COLS = 10;
DATA_WIDTH = 32;
DATA_PREFIX = "d:/Work/dissertation_microprocessor/altera_projects/fpga_igmv/matrices/test_"
#end Settings

def wr(string, indent=0):
	global source
	source.write(indent*"\t"+string+"\n")

source = open("igmv.v", "w")
DATA2 = "DATA2_0, "
for i in range(1,MATRIX_ROWS):
	DATA2 = DATA2 + "DATA2_" + str(i) + ", "
ioports = "OUT, ADDR, DATA1, " + DATA2 + "Read, RD, ST, CLK, RST"
wr("module igmv("+ioports+");")
wr("output [" + str(DATA_WIDTH * MATRIX_ROWS - 1) + ":0] OUT;",1)
ADDRESS_WIDTH = math.ceil(math.log(MATRIX_COLS,2))
wr("output [" + str(ADDRESS_WIDTH - 1) + ":0] ADDR;",1)
wr("input [" + str(DATA_WIDTH - 1) + ":0] DATA1;",1)
for i in range(0,MATRIX_ROWS):
	wr("input [" + str(DATA_WIDTH - 1) + ":0] DATA2_"+ str(i) +";", 1)
wr("output Read;",1)
wr("output RD;",1)
wr("input ST;",1)
wr("input CLK;",1)
wr("input RST;",1)
wr("")
for i in range(0, MATRIX_ROWS):
	wr("wire RD"+ str(i) + ";",1)
for i in range(0, MATRIX_ROWS):
	wr("wire Read"+ str(i) + ";",1)
wr("")
RD = "assign RD = "
for i in range(0, MATRIX_ROWS):
	RD = RD + "RD" + str(i) + " & ";
RD = RD[0:-2]
wr(RD + ";",1)
Read = "assign Read = "
for i in range(0, MATRIX_ROWS):
	Read = Read + "Read" + str(i) + " & ";
Read = Read[0:-2]
wr(Read + ";",1)
for i in range(0,MATRIX_ROWS):
	wr("rowmult rowmult"+str(i)+"(OUT["+str((i+1)*DATA_WIDTH-1)+":"+str(i*DATA_WIDTH)+"], ST, RD"+str(i)+", CLK, RST, DATA1, DATA2_"+str(i)+", ADDR, Read"+str(i)+");",1)
	wr("defparam rowmult"+str(i)+".matrix_width = "+str(MATRIX_COLS+1)+";",1)
	wr("defparam rowmult"+str(i)+".data_width = "+str(DATA_WIDTH)+";",1)
	wr("defparam rowmult"+str(i)+".address_width = "+str(ADDRESS_WIDTH)+";",1)

wr("endmodule")
wr("")
wr("module igmv_tb();")
wr("wire [" + str(DATA_WIDTH - 1) + ":0] DATA1;",1)
for i in range(0,MATRIX_ROWS):
	wr("wire [" + str(DATA_WIDTH - 1) + ":0] DATA2_"+ str(i) +";", 1)
wr("wire [" + str(ADDRESS_WIDTH - 1) + ":0] ADDR;",1)
wr("wire RD;",1)
wr("wire [" + str(DATA_WIDTH * MATRIX_ROWS - 1) + ":0] OUT;",1)
wr("reg rST;",1)
wr("reg rCLK;",1)
wr("reg rRST;",1)
wr("wire ST;",1)
wr("wire CLK;",1)
wr("wire RST;",1)

for i in range(0, MATRIX_ROWS):
	wr("syncmemory mem"+str(i)+"(.OUT_DATA(DATA2_"+str(i)+"), .ADDR(ADDR), .RD(Read), .CLK(CLK), .RST(RST));",1)
	wr("defparam mem"+str(i)+".data_width = "+str(DATA_WIDTH)+";",1)
	wr("defparam mem"+str(i)+".depth = "+str(MATRIX_COLS)+";",1)
	wr("defparam mem"+str(i)+".address_width = "+str(ADDRESS_WIDTH)+";",1)
	wr("defparam mem"+str(i)+".input_file = \""+DATA_PREFIX+str(i)+".bin\";",1)
	wr("defparam mem"+str(i)+".output_file = \""+DATA_PREFIX+str(i)+"o.bin\";",1)
wr("syncmemory mem_vector(.OUT_DATA(DATA1), .ADDR(ADDR), .RD(Read), .CLK(CLK), .RST(RST));",1)
wr("defparam mem_vector.data_width = "+str(DATA_WIDTH)+";",1)
wr("defparam mem_vector.depth = "+str(MATRIX_COLS)+";",1)
wr("defparam mem_vector.address_width = "+str(ADDRESS_WIDTH)+";",1)
wr("defparam mem_vector.input_file = \""+DATA_PREFIX+"vector.bin\";",1)
wr("defparam mem_vector.output_file = \""+DATA_PREFIX+"vectoro.bin\";",1)
wr("assign RST = rRST;",1)
wr("assign CLK = rCLK;",1)
wr("assign ST = rST;",1)
wr("igmv igmv1("+ioports+");")
wr("always begin",1)
wr("#5 rCLK = ~rCLK;",2)
wr("end",1)
wr("initial begin",1)
wr("rCLK = 0;",2)
wr("rST = 0;",2)
wr("rRST = 0;",2)
wr("#5 rRST = 1;",2)
wr("#5 rRST = 0;",2)
wr("#5 rST = 1;",2)
wr("#5 rST = 0;",2)
wr("end",1)
wr("endmodule")
source.close();