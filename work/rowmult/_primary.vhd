library verilog;
use verilog.vl_types.all;
entity rowmult is
    generic(
        matrix_width    : integer := 128;
        data_width      : integer := 32;
        address_width   : integer := 8
    );
    port(
        OUT_DATA        : out    vl_logic_vector;
        ST              : in     vl_logic;
        RD              : out    vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        DATA1           : in     vl_logic_vector;
        DATA2           : in     vl_logic_vector;
        ADDR            : out    vl_logic_vector;
        Read            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of matrix_width : constant is 1;
    attribute mti_svvh_generic_type of data_width : constant is 1;
    attribute mti_svvh_generic_type of address_width : constant is 1;
end rowmult;
