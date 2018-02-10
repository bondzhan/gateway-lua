local resty_md5 = require "resty.md5"
local resty_str = require "resty.string"
local resty_cjson = require "cjson"
local resty_fun = require "api.src.api_fun"
local md5 = resty_md5:new()
local req_body = ngx.var.request_body
local reqBodyArray = resty_cjson.decode(req_body)
--校验操作码
local opcode = reqBodyArray['opcode']
if opcode == nil or string.len(opcode) == 0 then 
	ngx.say(resty_fun:resJson("10000","操作码为空"))
	return
else
	--是否存在
	if resty_fun:opcodeCheck(opcode) == false then 
		ngx.say(resty_fun:resJson("10000","操作码不合法"))
		return
	end
end

--验签验证
local clientSign = reqBodyArray['sign']

if clientSign == nil or string.len(clientSign) == 0 then 
	ngx.say(resty_fun:resJson("10000","验签不合法"))
	return
end

--校验商户ID
local merchantId = reqBodyArray['merchant_id']
if merchantId == nil or string.len(merchantId) == 0 then 
	ngx.say(resty_fun:resJson("10000","商户ID为空"))
	return
else
	--获取商户私钥
	local merchantSecrykey = resty_fun:merchantCheck(merchantId)
	if merchantSecrykey == nil then 
		ngx.say(resty_fun:resJson("10000","商户不合法"))
		return 
	end

--	local preStr = resty_fun:reqBodySeperate(req_body)..merchantSecrykey
--	
--	ngx.say(preStr)
--	md5:update(preStr)
--	local digest = md5:final()
--	local sign = resty_str.to_hex(digest)
--	ngx.say(sign)
--	if sign ~= reqBodyArray["sign"] then 
--		ngx.say(resty_fun:resJson("10000","验签不合法"))
--		return
--	end  
--	ngx.say("md5:",resty_str.to_hex(digest))
end 

--ngx.say(resty_cjson.encode(res))
--
