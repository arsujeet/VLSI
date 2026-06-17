
class alu_driver extends uvm_driver #(alu_transaction);
  `uvm_component_utils(alu_driver)

  virtual alu_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRV", "No interface found!")
  endfunction

  task run_phase(uvm_phase phase);
    alu_transaction tx;
    forever begin
      seq_item_port.get_next_item(tx);
      @(posedge vif.clk);
      vif.a      <= tx.a;
      vif.b      <= tx.b;
      vif.opcode <= tx.opcode;
      @(posedge vif.clk);
      seq_item_port.item_done();
    end
  endtask

endclass
