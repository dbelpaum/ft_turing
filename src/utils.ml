let reverse_string s =
  let len = String.length s in
  let buffer = Buffer.create len in
  for i = len - 1 downto 0 do
    Buffer.add_char buffer s.[i]
  done;
  Buffer.contents buffer