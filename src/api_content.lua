local resty_md5 = require "resty.md5"
local resty_str = require "resty.string"
local resty_cjson = require "cjson"
local resty_fun = require "api.src.api_fun"
local md5 = resty_md5:new()

local req_body = ngx.var.request_body

ngx.req.set_header("Content-Type", "application/json")
local res = ngx.location.capture ('/proxy',
         {method = ngx.POST, body =  ngx.var.request_body} )
local resty_cjson = require "cjson"
ngx.say(res["body"])

