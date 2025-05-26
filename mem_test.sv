class mem_base_test extends uvm_test;  
  `uvm_component_utils(mem_base_test) 
  mem_env env;
  //mem_seq seq;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    endfunction
  
  function void build_phase(uvm_phase phase);
    `uvm_info("TEST","BASE_TEST",UVM_NONE) 
	env=mem_env::type_id::create("env",this);
	endfunction
  
  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction
  
  
 endclass


class mem_1_n_wr_rd_test extends mem_base_test; 
  `uvm_component_utils(mem_1_n_wr_rd_test) 
  
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    endfunction
    
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(int)::set(null,"*","tx_num",12);
  endfunction
 
  task run_phase(uvm_phase phase);
    mem_1_n_wr_rd_seq seq;
    seq=mem_1_n_wr_rd_seq::type_id::create("seq");
	phase.raise_objection(this);
 	seq.addr_temp_2=32'h10;
    seq.start(env.agent.sqr);
    phase.phase_done.set_drain_time(this,170);
  phase.drop_objection(this);
  endtask
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    if(mem_common::num_matches!=0 && mem_common::num_mismatches==0)begin
      `uvm_info("MEM_TEST","TEST_PASSED",UVM_MEDIUM)
      $display("Matchings=%0d",mem_common::num_matches);
      $display("Mismatching=%0d",mem_common::num_mismatches);
    end
    else begin
       `uvm_error("MEM_TEST","TEST_FAILED");
      $display("Matchings=%0d",mem_common::num_matches);
      $display("Mismatching=%0d",mem_common::num_mismatches);
     
    end
  endfunction
endclass



