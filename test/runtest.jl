using BAF
using JSON

infile = "/tmp/array.2x3.float32.baf"
#infile = "/tmp/array.2x3.uint8.baf"
x = bafread(infile)

println("Result:")
println(x)
println("Loading json...")

## filename, ordered, use_mmap
#println(JSON.parsefile("../test/tests.json", false, false))
#println(JSON.parsefile("../test/tests.json"))
## error...
