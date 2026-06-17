class alu_transaction extends uvm_sequence_item;
  rand logic [7:0] a;
  rand logic [7:0] b;
  rand logic [2:0] opcode;
  logic [7:0] result;

  `uvm_object_utils_begin(alu_transaction)
    `uvm_field_int(a,      UVM_ALL_ON)
    `uvm_field_int(b,      UVM_ALL_ON)
    `uvm_field_int(opcode, UVM_ALL_ON)
    `uvm_field_int(result, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "alu_transaction");
    super.new(name);
  endfunction

  constraint valid_opcode { opcode inside {[0:7]}; }
  constraint no_overflow  { a <= 8'd127; b <= 8'd127; }
endclass
