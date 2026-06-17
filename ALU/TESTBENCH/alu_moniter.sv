class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;
  uvm_analysis_port #(alu_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);
    if(!uvm_config_db #(virtual alu_if)::get(
        this, "", "vif", vif))
      `uvm_fatal("MON", "No interface found!")
  endfunction

  // Sample DUT output every clock
  task run_phase(uvm_phase phase);
    alu_transaction tx;
    forever begin
      @(posedge vif.clk);
      tx        = alu_transaction::type_id::create("tx");
      tx.a      = vif.a;
      tx.b      = vif.b;
      tx.opcode = vif.opcode;
      tx.result = vif.result;
      ap.write(tx); // send to scoreboard
    end
  endtask

endclass