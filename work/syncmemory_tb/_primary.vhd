library verilog;
use verilog.vl_types.all;
entity syncmemory_tb is
    generic(
        data_width      : integer := 32;
        depth           : integer := 256;
        address_width   : integer := 8;
        input_file      : string  := "d:/Work/dissertation_microprocessor/altera_projects/filter/lol.bin";
        output_file     : string  := "d:/Work/dissertation_microprocessor/altera_projects/filter/lolo.bin"
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of depth : constant is 1;
    attribute mti_svvh_generic_type of address_width : constant is 1;
    attribute mti_svvh_generic_type of input_file : constant is 1;
    attribute mti_svvh_generic_type of output_file : constant is 1;
end syncmemory_tb;
