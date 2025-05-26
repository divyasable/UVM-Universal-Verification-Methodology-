class mem_mon extends uvm_monitor;
  
    virtual mem_intrf vif;
  `uvm_component_utils(mem_mon);
  
   
  uvm_analysis_port#(mem_tx)ap_port;
 
 
  function new(string name,uvm_component parent);
        super.new(name,parent);
    ap_port=new("ap_port",this);
  endfunction
    function void build_phase(uvm_phase phase);
      `uvm_info("MON","MON BUILD PHASE",UVM_NONE);
	  endfunction
     mem_tx tx;
  task run();
    vif=top.pif;
 
    forever begin
      
      @(vif.mon_cb);
    if(vif.mon_cb.valid && vif.mon_cb.ready)begin
        tx=new();
        tx.addr=vif.mon_cb.addr;
      tx.wdata=vif.mon_cb.wdata;
      tx.rdata=vif.mon_cb.rdata;
        tx.wr_rd=vif.mon_cb.wr_rd;
        tx.print();
      ap_port.write(tx);
	  end
    end
    
  endtask
endclass



