# BAF.jl
# Tools for reading and writing baf files (http://trybaf.org)

module BAF

## 
dmap = {
  convert(Uint8,0x28) => Float32
}

function readheader(fid)

  magic = read(fid, Uint8, 4)
  if "baf1".data != magic
    error("Did not find \"baf1\" at start of file")
  end

  v = read(fid, Uint32)
  # skip is seek from current pos
  skip(fid,v)

  v = read(fid, Uint32)
  skip(fid,v)

end


#?? function read(f:IO)
##
## f:IOStream
function _bafread(fid)

  readheader(fid)

  typeid = read(fid, Uint8)
  ## if ...

  nbytes = read(fid,Uint32)
  dtypeid = read(fid,Uint8)

  if haskey(dmap, dtypeid)
    dtype = Float32
  else
    error("Unknown type id: $dtypeid")
  end

  byte = read(fid,Uint8)

  n1 = read(fid,Uint32)
  n2 = read(fid,Uint32)

  numel = n1 * n2

  value = read(fid,dtype,numel)

  return value
end



function bafread(filename::String)

  println("bafread: $filename ...")

  #fid = bafopen(filename)
  fid = open(filename, "r")

  value = _bafread(fid)

  close(fid)  

  value

end

###############
###############
###############

##?
##function matwrite{S,T}(filename::String, dict::Dict{S, T})
function bafwrite(filename::String)
end

export bafread

end
