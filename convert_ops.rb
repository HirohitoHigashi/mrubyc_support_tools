#!/usr/bin/env ruby
#
# convert mruby's ops.h to mruby/c's enum
#
# (usage)
#   convert_ops.rb PATH/TO/MRUBY/include/mruby/ops.h > tempfile.c
#
#  and merge manually opcode.h and tempfile.c
#

#
# main
#
if ARGV.size != 1
  puts "usage: convert_ops.rb PATH/TO/MRUBY/include/mruby/ops.h > tempfile.c"
  exit
end

opecode_num = 0

File.open( ARGV[0] ) {|file|
  while txt = file.gets
    if /OPCODE\((\w+)\s*,\s*(\w+)\s*\)\s*\/\*(.+)\*\// =~ txt
      opecode,operands,semantics = $1,$2,$3.strip
      printf "  OP_%-11s= 0x%02x, //!< %-5s%s\n", opecode, opecode_num, operands, semantics
#      printf "    case OP_%s:%sret = op_%-10s(vm, regs); break;\n",
#             opecode, " " * (11 - opecode.size), opecode.downcase
      opecode_num += 1
    end
  end
}
