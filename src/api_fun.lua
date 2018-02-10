local _fun = {}
local cjson = require('cjson')
--指定JSON格式返回
function _fun:resJson(retCode,retMsg,retEntity)
	local arr_return = {};
	arr_return['retCode'] = retCode;
	arr_return['retMsg'] = retMsg
	arr_return['retEntity'] = retEntity
	return cjson.encode(arr_return);
end
--拼接及过滤参数
function _fun:reqBodySeperate(req_body)
	local req_body_array = cjson.decode(req_body)
        local req_body_key = {}
        for i,v in pairs (req_body_array) do
		if i == "items" or i == "category_list" then 
			local itemStr = cjson.encode(v)
			if(string.len(itemStr) > 0) then
				table.insert(req_body_key,i)
			end
		else
		        if string.lower(i) ~= "sign" and string.lower(i) ~= "sign_type" then
                        	table.insert(req_body_key,i)
			end
                end
        end
        table.sort(req_body_key)
	local retStr = ""
        for j,v in pairs (req_body_key) do
                if j == 1 then
			if type(v) == "table" then 
				retStr = retStr..v.."="..string.gsub(cjson.encode(req_body_array[v]),'"',"")
			else
				retStr = retStr..v.."="..req_body_array[v]
 			end 
                else
			if type(v) == "table" then
--                                retStr = retStr.."&"..v.."="..cjson.encode(req_body_array[v])
                                retStr = retStr.."&"..v.."="..string.gsub(cjson.encode(req_body_array[v]),'"',"")

                        else
                                retStr = retStr.."&"..v.."="..req_body_array[v]
                        end

                end
        end
	return retStr
end

--操作码是否存在
function _fun:opcodeCheck(opcode)
        for k,v in pairs (OPCODE_CONFIG) do
                if v == opcode then
                      return true;
                end
        end
	return false;
end 

--商户ID是否存在
function _fun:merchantCheck(merchantId)
	local merchantIdArray = cjson.decode(MERCHANT_ID_CONFIG)
	for k,v in pairs (merchantIdArray) do
        	if k == merchantId then
        		return v;
                end
	end
	return nil;
end

return _fun;


