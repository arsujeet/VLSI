
class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_transaction, alu_scoreboard) ap;

  int pass_count = 0;
  int fail_count = 0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);
  endfunction

  function void write(alu_transaction tx);
    logic [7:0] expected;
    case(tx.opcode)
      3'b000: expected = tx.a + tx.b;
      3'b001: expected = tx.a - tx.b;
      3'b010: expected = tx.a & tx.b;
      3'b011: expected = tx.a | tx.b;
      3'b100: expected = tx.a ^ tx.b;
      3'b101: expected = tx.a << 1;
      3'b110: expected = tx.a >> 1;
      3'b111: expected = (tx.a < tx.b) ? 8'b1 : 8'b0;
      default: expected = 8'b0;
    endcase

    if(tx.result === expected) begin
      pass_count++;
      `uvm_info("SB", $sformatf("PASS | op=%0b a=%0d b=%0d | got=%0d exp=%0d",
        tx.opcode, tx.a, tx.b, tx.result, expected), UVM_LOW)
    end else begin
      fail_count++;
      `uvm_error("SB", $sformatf("FAIL | op=%0b a=%0d b=%0d | got=%0d exp=%0d",
        tx.opcode, tx.a, tx.b, tx.result, expected))
    end
  endfunction

  function void report_phase(uvm_phase phase);
    `uvm_info("SB", $sformatf("RESULTS: PASS=%0d FAIL=%0d",
      pass_count, fail_count), UVM_LOW)
  endfunction

endclass
