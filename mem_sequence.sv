class mem_base_sequence extends uvm_sequence#(mem_tx);   
// mem_tx tx_t;
  `uvm_object_utils(mem_base_sequence)
  uvm_phase phase;
 //bit [`ADDR_WIDTH-1:0] txQ[$];
  function new(string name="");
    super.new(name);
  endfunction
  
 
endclass

class mem_1_wr_seq extends mem_base_sequence;
  `uvm_object_utils(mem_1_wr_seq);
 
  rand bit [`ADDR_WIDTH-1:0]addr_temp; 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req,{req.wr_rd==1'b1;req.addr==addr_temp;})
  endtask
endclass

class mem_1_rd_seq extends mem_base_sequence;
  `uvm_object_utils(mem_1_rd_seq)
 
  rand bit [`ADDR_WIDTH-1:0]addr_temp; 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req,{req.wr_rd==1'b0;req.addr==addr_temp;})
  endtask
endclass



class mem_1_wr_rd_seq extends mem_base_sequence;
  `uvm_object_utils(mem_1_wr_rd_seq);
 
    mem_1_wr_seq wr_seq;
  mem_1_rd_seq rd_seq;
 
 
  rand bit [`ADDR_WIDTH-1:0]addr_temp_1; 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    begin
      `uvm_do_with(wr_seq,{wr_seq.addr_temp==addr_temp_1;}) 
	  `uvm_do_with(rd_seq,{rd_seq.addr_temp==addr_temp_1;}) 
	  end
  endtask
endclass


class mem_1_n_wr_rd_seq extends mem_base_sequence;
  `uvm_object_utils(mem_1_n_wr_rd_seq);
  
  mem_1_wr_rd_seq seq;
 
 int tx_num;
 
  rand bit [`ADDR_WIDTH-1:0]addr_temp_2; 
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    uvm_config_db#(int)::get(null,"","tx_num",tx_num);
    for(int i=0;i<tx_num;i++)begin
      `uvm_do_with(seq,{seq.addr_temp_1==addr_temp_2+2*i;}) 
	  end
  endtask
endclass


