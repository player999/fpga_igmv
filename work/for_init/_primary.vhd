library verilog;
use verilog.vl_types.all;
entity for_init is
    generic(
        in_w            : integer := 64
    );
    port(
        IN_DATA         : in     vl_logic_vector;
        OUT_DATA        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of in_w : constant is 1;
end for_init;
