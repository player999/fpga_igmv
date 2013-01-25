library verilog;
use verilog.vl_types.all;
entity rowmult_tb is
    generic(
        data_width      : integer := 32;
        depth           : integer := 256;
        address_width   : integer := 8;
        input_file1     : string  := "d:/Work/dissertation_microprocessor/altera_projects/fpga_igmv/M1.bin";
        input_file2     : string  := "d:/Work/dissertation_microprocessor/altera_projects/fpga_igmv/M2.bin";
        output_file1    : string  := "d:/Work/dissertation_microprocessor/altera_projects/fpga_igmv/MO2.bin";
        output_file2    : string  := "d:/Work/dissertation_microprocessor/altera_projects/fpga_igmv/MO2.bin"
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of depth : constant is 1;
    attribute mti_svvh_generic_type of address_width : constant is 1;
    attribute mti_svvh_generic_type of input_file1 : constant is 1;
    attribute mti_svvh_generic_type of input_file2 : constant is 1;
    attribute mti_svvh_generic_type of output_file1 : constant is 1;
    attribute mti_svvh_generic_type of output_file2 : constant is 1;
end rowmult_tb;
