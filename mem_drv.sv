class mem_drv extends uvm_driver#(mem_tx);
    virtual mem_intrf vif;
  
  `uvm_component_utils(mem_drv);
   
  function new(string name="driver",uvm_component parent);
    super.new(name,parent);
  endfunction
    function void build_phase(uvm_phase phase);
      `uvm_info("DRV","DRV BUILD PHASE",UVM_NONE); 
	  endfunction
  
  task run_phase(uvm_phase phase);
     forever begin
    vif=top.pif;
   
      seq_item_port.get_next_item(req);
	  req.print();
      drive_tx(req);
      
 seq_item_port.item_done();
      end
  endtask
  
  task drive_tx(mem_tx tx);
    @(vif.bfm_cb);
   
     vif.bfm_cb.addr<=tx.addr; 
    if(tx.wr_rd==1) vif.bfm_cb.wdata<=tx.wdata; else tx.rdata<=vif.bfm_cb.rdata;
     vif.bfm_cb.wr_rd <=tx.wr_rd;
        vif.bfm_cb.valid<=1;

    wait(vif.bfm_cb.ready==1);
       @(vif.bfm_cb);
    vif.bfm_cb.addr<=0;
    vif.bfm_cb.wdata<=0;
    vif.bfm_cb.wr_rd<=0;
    vif.bfm_cb.valid<=0;
    
  endtask
    
    
  
endclass



