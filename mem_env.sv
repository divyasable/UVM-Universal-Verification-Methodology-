class mem_env extends uvm_env;
  `uvm_component_utils(mem_env);
  mem_agent agent;
  mem_sbd sbd;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  
    function void build_phase(uvm_phase phase);
      `uvm_info("ENV","ENV BUILD PHASE",UVM_NONE);     
	  agent=mem_agent::type_id::create("agent",this);
	  sbd=mem_sbd::type_id::create("sbd",this); 
  endfunction
  
  function void connect_phase(uvm_phase phase);
    agent.mon.ap_port.connect(sbd.analysis_imp);
  endfunction
endclass
