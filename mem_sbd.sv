class mem_sbd extends uvm_scoreboard;
  uvm_analysis_imp#(mem_tx, mem_sbd) analysis_imp; 
  `uvm_component_utils(mem_sbd)
  //virtual mem_intrf vif;
  
  mem_tx tx;
  bit[`WIDTH-1:0]mem [int];
  
  function void build_phase(uvm_phase phase);
    analysis_imp=new("analysis_imp",this);   
	endfunction
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  
  function void write(mem_tx t);
    
    $cast(tx,t);
    if(tx.wr_rd==1)begin
      mem[tx.addr]=tx.wdata;
    end
    else begin
      if(tx.rdata==mem[tx.addr]) begin
        mem_common::num_matches++;
        $display($time, "tx.rdata==mem[tx.addr] \n %d    %d",tx.rdata,mem[tx.addr]); end
      else 
        mem_common::num_mismatches++;
    end
  endfunction
endclass
