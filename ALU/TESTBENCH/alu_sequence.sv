class alu_rand_seq extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_rand_seq)

  function new(string name = "alu_rand_seq");
    super.new(name);
  endfunction

  task body();
    alu_transaction tx;
    logic [7:0] a_vals [5] = '{8'd10, 8'd25, 8'd50, 8'd100, 8'd127};
    logic [7:0] b_vals [5] = '{8'd5,  8'd10, 8'd25, 8'd50,  8'd100};
    logic [2:0] ops   [8] = '{0, 1, 2, 3, 4, 5, 6, 7};

    repeat(50) begin
      tx = alu_transaction::type_id::create("tx");
      start_item(tx);
      // Manual "pseudo-random" assignment — no license needed
      tx.a      = a_vals[$urandom_range(0,4)];
      tx.b      = b_vals[$urandom_range(0,4)];
      tx.opcode = ops[$urandom_range(0,7)];
      finish_item(tx);
    end
  endtask

endclass
