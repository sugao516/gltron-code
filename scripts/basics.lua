function script_print(...)
   io.write("[script] ")
   local arg={select('1',...)}
   for i=1,#arg do
      io.write(arg[i])
   end
   io.write("\n")
end

