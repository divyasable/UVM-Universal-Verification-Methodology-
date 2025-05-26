class mem_agent extends uvm_agent;
  `uvm_component_utils(mem_agent);
  mem_sqr sqr;
  mem_drv drv;
  mem_mon mon;
  mem_cov cov;
  
  function new(string name,uvm_component parent);
    super.new(name, parent);
    
  endfunction
function void build_phase (uvm_phase phase);
  `uvm_info("AGENT","AGENT BUILD PHASE",UVM_NONE); 

  sqr=mem_sqr::type_id::create("sqr",this);
  drv=mem_drv::type_id::create("drv",this);
  mon=mem_mon::type_id::create("mon",this);
  cov=mem_cov::type_id::create("cov",this);
endfunction
  
    function void connect();
    `uvm_info("AGT","AGT CONNECT PHASE",UVM_NONE);
    drv.seq_item_port.connect(sqr.seq_item_export);
    mon.ap_port.connect(cov.analysis_export);
    
  endfunction

endclass



