local socket = require("socket")
math.randomseed(socket.gettime()*1000)
math.random(); math.random(); math.random()

local url = "http://localhost:5000"

local function search_hotel() 
  local in_date = math.random(9, 23)
  local out_date = math.random(in_date + 1, 24)

  local in_date_str = tostring(in_date)
  if in_date <= 9 then
    in_date_str = "2015-04-0" .. in_date_str 
  else
    in_date_str = "2015-04-" .. in_date_str
  end

  local out_date_str = tostring(out_date)
  if out_date <= 9 then
    out_date_str = "2015-04-0" .. out_date_str 
  else
    out_date_str = "2015-04-" .. out_date_str
  end

  local lat = 38.0235 + (math.random(0, 481) - 240.5)/1000.0
  local lon = -122.095 + (math.random(0, 325) - 157.0)/1000.0

  local method = "GET"
  local path = url .. "/hotels?inDate=" .. in_date_str .. 
    "&outDate=" .. out_date_str .. "&lat=" .. tostring(lat) .. "&lon=" .. tostring(lon)

  local headers = {}
  -- headers["Content-Type"] = "application/x-www-form-urlencoded"
  return wrk.format(method, path, headers, nil)
end

request = function()
    return search_hotel(url)
end

function done(summary, latency, requests)
  print(string.format("Total Requests: %d", summary.requests))
  print(string.format("HTTP errors: %d", summary.errors.status))
  print(string.format("Requests timed out: %d", summary.errors.timeout)) 
  print(string.format("Bytes received: %d", summary.bytes))
  print(string.format("Socket connect errors: %d", summary.errors.connect))
  print(string.format("Socket read errors: %d", summary.errors.read))
  print(string.format("Socket write errors: %d", summary.errors.write))
end