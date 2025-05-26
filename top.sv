//`define ADDR_WIDTH 6
`define ADDR_WIDTH $clog2(`DEPTH)
`define WIDTH 8
`define DEPTH 16




import uvm_pkg::*;

`include "uvm_macros.svh"

`include "mem_tx.sv"
`include "memory.sv"
`include "mem_intrf.sv"
`include "mem_common.sv"
`include "mem_sequence.sv"
`include "mem_sqr.sv"
`include "mem_drv.sv"
`include "mem_mon.sv"
`include "mem_cov.sv" 
`include "mem_sbd.sv"
`include "mem_agent.sv"
`include "mem_env.sv"
`include "mem_test.sv"



module top;

  bit clk,rst;
  
 
  mem_intrf pif(clk,rst);
  
  
  memory dut(.clk(pif.clk),.rst(pif.rst),.addr(pif.addr),.wdata(pif.wdata),.rdata(pif.rdata),.wr_rd(pif.wr_rd),.valid(pif.valid),.ready(pif.ready)
  );
  
 
  initial begin
    clk=0;
   
    forever #5 clk=~clk;
  end
  
 
  initial begin
    rst=1;
    repeat(2)@(posedge clk);
    rst=0;
    end
  

  
  initial begin

    run_test("mem_1_n_wr_rd_test");
  end
  
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars(0);
  end
endmodule




