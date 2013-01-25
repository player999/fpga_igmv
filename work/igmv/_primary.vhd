library verilog;
use verilog.vl_types.all;
entity igmv is
    port(
        \OUT\           : out    vl_logic_vector(319 downto 0);
        ADDR            : out    vl_logic_vector(3 downto 0);
        DATA1           : in     vl_logic_vector(31 downto 0);
        DATA2_0         : in     vl_logic_vector(31 downto 0);
        DATA2_1         : in     vl_logic_vector(31 downto 0);
        DATA2_2         : in     vl_logic_vector(31 downto 0);
        DATA2_3         : in     vl_logic_vector(31 downto 0);
        DATA2_4         : in     vl_logic_vector(31 downto 0);
        DATA2_5         : in     vl_logic_vector(31 downto 0);
        DATA2_6         : in     vl_logic_vector(31 downto 0);
        DATA2_7         : in     vl_logic_vector(31 downto 0);
        DATA2_8         : in     vl_logic_vector(31 downto 0);
        DATA2_9         : in     vl_logic_vector(31 downto 0);
        Read            : out    vl_logic;
        RD              : out    vl_logic;
        ST              : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic
    );
end igmv;
