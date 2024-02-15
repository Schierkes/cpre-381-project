-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Fetch Logic Signals
  signal s_4            : std_logic_vector(31 downto 0) := x"00000004"; -- signal that is always 4 for adding to PC
  signal s_PCin         : std_logic_vector(31 downto 0); -- signal that goes into PC module from fetch logic
  signal s_PCw4         : std_logic_vector(31 downto 0); -- signal of PC after 4 is added to move to the next Addr, becomes next PC for non branching or jumping instructions
  signal s_BranchAddOut : std_logic_vector(31 downto 0); -- signal for the output of the branch adder
  signal s_BranchMuxOut : std_logic_vector(31 downto 0); --signal for output of branch mux
  signal s_shift2bitOut : std_logic_vector(31 downto 0); --signal for output of 32 wide 2 bit shifter
  signal s_JumpShiftOut : std_logic_vector(27 downto 0); --signal for caluclating 28 bits from 26-0 from the instruction
  signal s_JumpMuxOut   : std_logic_vector(31 downto 0); --signal for output of the JumpMux
  signal s_JALMuxOut    : std_logic_vector(31 downto 0); --signal for output of the JALMux
  signal s_SignExtendOut: std_logic_vector(31 downto 0); --signal for output of the sign extender
  signal s_RegToMemMuxOut:std_logic_vector(31 downto 0); --signal for output of the Reg to mem mux
  signal s_RegDestMuxOut: std_logic_vector(4 downto 0); --signal for output of the RegDestMux
  signal s_AluSrcMuxOut : std_logic_vector(31 downto 0); --signal for output of ALU Src Mux
  signal s_RegWriteMuxOut: std_logic; --signal for output of RegWrite Mux
  
  -- Control Signals
  signal s_Jump         : std_logic;
  signal s_JAL          : std_logic;
  signal s_JR           : std_logic;
  signal s_Branch       : std_logic;
  signal s_BranchNeq    : std_logic;
  signal s_ZeroSign     : std_logic;
  signal s_RegWrite     : std_logic;
  signal s_RegToMem     : std_logic;
  signal s_RegDest      : std_logic_vector(1 downto 0);
  signal s_AluSrc       : std_logic;
  signal s_Movn         : std_logic;

  -- ALU Signals
  signal s_Zero         : std_logic;
  signal s_ALUOut       : std_logic_vector(31 downto 0);

  --ALU Control Signals
  signal s_OpSel: std_logic_vector(2 downto 0);
  signal s_LeftRight: std_logic;
  signal s_LogArth: std_logic;
  signal s_AddSub: std_logic;
  signal s_AluOp: std_logic_vector(2 downto 0);

  -- Register File Signals
  signal s_ReadRegA     : std_logic_vector(31 downto 0); -- first output from RegFile
  signal s_ReadRegB     : std_logic_vector(31 downto 0); -- first output from RegFile

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  signal s_BranchMuxIn : std_logic; 
  signal s_NotZero        : std_logic; 

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
  end component;

  component N_Bit_Reg 
    generic(N: integer := 32);
    port(i_ReadWrite   : in std_logic;
         i_Data        : in std_logic_vector(N-1 downto 0);
         i_CLK         : in std_logic;
         i_CLR         : in std_logic;
         o_Output      : out std_logic_vector(N-1 downto 0));
  end component;

  component Adder_32
    port(i_C          : in std_logic;
         i_A          : in std_logic_vector(31 downto 0);
         i_B          : in std_logic_vector(31 downto 0);
         o_C	        : out std_logic;
         o_S          : out std_logic_vector(31 downto 0));
  end component;

  component shift2bit
    port(iShift : in std_logic_vector(31 downto 0);
         oShift : out std_logic_vector(31 downto 0));
  end component;

  component mux2t1_32
    port(i_Select : in std_logic;
         i_D0     : in std_logic_vector(31 downto 0);
         i_D1     : in std_logic_vector(31 downto 0);
         o_Output : out std_logic_vector(31 downto 0));
  end component;

  component shift2bit_26
    port(iShift : in std_logic_vector(25 downto 0);
         oShift : out std_logic_vector(27 downto 0));
  end component;

  component Extender
    port(i_data    : in std_logic_vector(15 downto 0);
         i_signSel : in std_logic;
         o_out     : out std_logic_vector(31 downto 0));
  end component;

  component RegFile
    generic(N: integer := 32);
    port(i_data: in std_logic_vector(31 downto 0);
         i_address1: in std_logic_vector(4 downto 0);
         i_address2: in std_logic_vector(4 downto 0);
         i_writeAddress: in std_logic_vector(4 downto 0);
         i_readWrite: in std_logic;
         i_CLR: in std_logic;
         i_CLK: in std_logic;
         o_A: out std_logic_vector(31 downto 0);
         o_B: out std_logic_vector(31 downto 0));
  end component;
  
  component mux4t1_5 is
    port(i_Select : in std_logic_vector(1 downto 0);
         i_D0     : in std_logic_vector(4 downto 0);
         i_D1     : in std_logic_vector(4 downto 0);
         i_D2     : in std_logic_vector(4 downto 0);
         i_D3     : in std_logic_vector(4 downto 0);
         o_Out    : out std_logic_vector(4 downto 0));
end component;

component Control is
  port(i_Opcode: in std_logic_vector(5 downto 0);
       i_Funct: in std_logic_vector(5 downto 0);
       o_ALUOp: out std_logic_vector(2 downto 0);
       o_ALUSrc: out std_logic;
       o_ZeroSignExt: out std_logic;
       o_RegToMem: out std_logic;
       o_RegWr: out std_logic;
       o_RegDst: out std_logic_vector(1 downto 0);
       o_DMemWr: out std_logic;
       o_Branch: out std_logic;
       o_BranchNeq: out std_logic;
       o_Jump: out std_logic;
       o_Jr: out std_logic;
       o_Jal: out std_logic);
end component;

component ALU is
  generic(N : integer := 32);
  port(i_A: in std_logic_vector(31 downto 0);
       i_B: in std_logic_vector(31 downto 0);
       i_shamt: in std_logic_vector(4 downto 0);
       i_LeftRight: in std_logic;
       i_LogArth: in std_logic;
       i_AddSub: in std_logic;
       i_OpSel: in std_logic_vector(2 downto 0);
       o_ALUOut: out std_logic_vector(31 downto 0);
       o_Zero: out std_logic;
       o_Overflow: out std_logic);
end component;

component ALUControl is
  port(i_ALUOp: in std_logic_vector(2 downto 0);
       i_Funct: in std_logic_vector(5 downto 0);
       o_OpSel: out std_logic_vector(2 downto 0);
       o_LeftRight: out std_logic;
       o_LogArth: out std_logic;
       o_AddSub: out std_logic);
end component;

component mux2t1 is
	port(sel: in std_logic;
		   a: in std_logic;
		   b: in std_logic;
		   o: out std_logic);
end component;
  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

begin

  s_BranchMuxIn <= (s_Branch and s_Zero) or (s_BranchNeq and (not(s_Zero)));
  s_NotZero <= not(s_Zero);

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  PC: N_Bit_Reg
    generic map(N => 32)
    port map(i_readWrite => '1',
             i_Data => s_PCin, 
             i_Clk => iClk, 
             i_CLR => iRST, 
             o_Output => s_NextInstAddr);
  
  PCplus4Adder: Adder_32
    port map(i_C => '0',
             i_A => s_NextInstAddr,
             i_B => s_4,
             o_C => open,
             o_S => s_PCw4);
    
  Shifter32: shift2bit
    port map(iShift => s_SignExtendOut,
             oShift => s_shift2bitOut);

  BranchAdder: Adder_32
    port map(i_C => '0',
             i_A => s_PCw4,
             i_B => s_shift2bitOut,
             o_C => open,
             o_S => s_BranchAddOut);

  BranchMux: mux2t1_32
    port map(i_Select => s_BranchMuxIn,
             i_D0 => s_PCw4,
             i_D1 => s_BranchAddOut,
             o_Output => s_BranchMuxOut);

  JumpShifter: shift2bit_26
    port map(iShift => s_Inst(25 downto 0),
             oShift => s_JumpShiftOut);

  JumpMux: mux2t1_32
    port map(i_Select => s_Jump,
             i_D0 => s_BranchMuxOut,
             i_D1(31 downto 28) => s_PCw4(31 downto 28),
             i_D1(27 downto 2) => s_JumpShiftOut,
             i_D1(1 downto 0) => "00", -- final jump address
             o_Output => s_JumpMuxOut);

  JRMux: mux2t1_32
    port map(i_Select => s_JR,
             i_D0 => s_JumpMuxOut,
             i_D1 => s_ReadRegA,
             o_Output => s_PCin);  --final stage of fetch logic, output of this mux is data in for PC
          
  JALMux: mux2t1_32
    port map(i_Select => s_JAL,
             i_D0 => s_RegToMemMuxOut,
             i_D1 => s_PCw4,
             o_Output => s_JALMuxOut); --output used for WrData in RegisterFile

  SignExtender: Extender
    port map(i_data => s_Inst(15 downto 0),
             i_signSel => s_ZeroSign,
             o_out => s_SignExtendOut);

  RegisterFile: RegFile
    generic map(N => 32)
    port map(i_data => s_JALMuxOut,
             i_address1 => s_Inst(25 downto 21),
             i_address2 => s_Inst(20 downto 16),
             i_writeAddress => s_RegDestMuxOut,
             i_readWrite => s_RegWriteMuxOut,
             i_CLR => iRST,
             i_CLK => iCLK,
             o_A => s_ReadRegA,
             o_B => s_ReadRegB);

  RegWriteMux: mux2t1
    port map(sel => s_Movn,
            a => s_RegWr,
            b => s_NotZero,
            o => s_RegWriteMuxOut);

  RegToMemMux: mux2t1_32
      port map(i_Select => s_RegToMem,
               i_D0 => s_ALUOut,
               i_D1 => s_DMemOut,
               o_Output => s_RegToMemMuxOut); 
  
  DstSrcMux: mux4t1_5
      port map(i_Select => s_RegDest,
               i_D0     => s_Inst(15 downto 11), --rd
               i_D1     => s_Inst(20 downto 16), --rs
               i_D2     => "11111", --$ra
               i_D3     => s_Inst(25 downto 21), --unused
               o_Out    => s_RegDestMuxOut);
  
  ALUSrcMux: mux2t1_32
      port map(i_Select => s_AluSrc,
               i_D0 => s_ReadRegB,
               i_D1 => s_SignExtendOut,
               o_Output => s_AluSrcMuxOut);

  ALU_Control: ALUControl
      port map(i_ALUOp => s_ALUOp,
               i_Funct => s_Inst(5 downto 0),
               o_OpSel => s_OpSel,
               o_LeftRight => s_LeftRight,
               o_LogArth => s_LogArth,
               o_AddSub => s_AddSub);

  ALU_Unit: ALU
    generic map(N => 32)
    port map(i_A => s_ReadRegA,
             i_B => s_AluSrcMuxOut,
             i_shamt => s_Inst(10 downto 6),
             i_LeftRight => s_Leftright,
             i_LogArth => s_LogArth,
             i_AddSub => s_AddSub,
             i_OpSel => s_ALUOp,
             o_ALUOut => oALUOut,
             o_Zero => s_Zero,
             o_Overflow => s_Ovfl);

  oALUOut <= s_ALUOut;

  Control_Unit: Control
    port map(i_Opcode => s_Inst(31 downto 26),
             i_Funct => s_Inst(5 downto 0),
             o_ALUOp => s_ALUOp,
             o_ALUSrc => s_AluSrc,
             o_ZeroSignExt => s_ZeroSign,
             o_RegToMem => s_RegToMem,
             o_RegWr => s_RegWrite,
             o_RegDst => s_RegDest,
             o_DMemWr => s_DMemWr,
             o_Branch => s_Branch,
             o_BranchNeq => s_BranchNeq,
             o_Jump => s_Jump,
             o_Jr => s_JR,
             o_Jal => s_JAL);
  

  
             



  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 

end structure;

