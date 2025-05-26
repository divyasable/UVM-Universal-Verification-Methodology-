//RTL CODE
module memory(clk,rst,wr_rd,wdata,rdata,valid,ready,addr);
parameter WIDTH=`WIDTH;
parameter DEPTH=`DEPTH;
parameter ADDR_WIDTH=`ADDR_WIDTH;

input clk,rst,wr_rd,valid;
input [`WIDTH-1:0]wdata;
input [`ADDR_WIDTH-1:0]addr;
output reg ready;
output reg [`WIDTH-1:0]rdata;

//INTERNAL REG
reg [`WIDTH-1:0]mem[`DEPTH-1:0];
integer i;

always@(posedge clk)begin
 if(rst==1)begin
    ready=0;
	rdata=0;
	for(i=0;i<`DEPTH;i=i+1)mem[i]=0;
	end
	else begin
	if(valid==1)begin
	   ready=1;
	   if(wr_rd==1)mem[addr]=wdata;
	   else rdata=mem[addr];
	 end
	 else 
	    ready=0;
      end
    end
endmodule

