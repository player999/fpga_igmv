library verilog;
use verilog.vl_types.all;
entity for_body is
    generic(
        address_width   : integer := 8;
        mem_dw          : integer := 32;
        in_w            : vl_notype;
        out_w           : vl_notype
    );
    port(
        IN_DATA         : in     vl_logic_vector;
        OUT_DATA        : out    vl_logic_vector;
        RD              : out    vl_logic;
        ST              : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        DATA1           : in     vl_logic_vector;
        DATA2           : in     vl_logic_vector;
        ADDR            : out    vl_logic_vector;
        Read            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of address_width : constant is 1;
    attribute mti_svvh_generic_type of mem_dw : constant is 1;
    attribute mti_svvh_generic_type of in_w : constant is 3;
    attribute mti_svvh_generic_type of out_w : constant is 3;
end for_body;
