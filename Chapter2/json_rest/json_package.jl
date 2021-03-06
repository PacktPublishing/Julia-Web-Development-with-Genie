using HTTP, JSON

todos = Dict(     # type is Dict{Int64, String}
    1 => "Getting groceries",
    2 => "Visiting my therapist",
    3 => "Getting a haircut"
)

json_string = JSON.json(todos)      # 1
# "{\"2\":\"Visiting my therapist\",\"3\":\"Getting a haircut\",\"1\":\"Getting groceries\"}"
todos2 = JSON.parse(json_string)
# Dict{String, Any} with 3 entries:
#   "1" => "Getting groceries"
#   "2" => "Visiting my therapist"
#   "3" => "Getting a haircut"

resp = HTTP.Response(
    200,
    ["Content-Type" => "application/json"],
    body=JSON.json(todos)  # 1
)

# HTTP.Messages.Response:
# """
# HTTP/1.1 200 OK
# Content-Type: application/json

# {"2":"Visiting my therapist","3":"Getting a haircut","1":"Getting groceries"}"""

body = HTTP.payload(resp) # 2 - a Vector of UInt8 bytes
io = IOBuffer(body)       # 3 
todos = JSON.parse(io)    # 4
# Dict{String, Any} with 3 entries:
#   "1" => "Getting groceries"
#   "2" => "Visiting my therapist"
#   "3" => "Getting a haircut"