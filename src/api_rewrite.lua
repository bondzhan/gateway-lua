local fun = require "api.src.api_fun"
--ngx.say(ngx.var.remote_addr)
function isPermission()
	for k,v in pairs(CLIENT_IP_CONFIG) do
	--	ngx.say("config="..v)
        	if ngx.var.remote_addr == v then
                	return true
        	end
	end
	return false
end

local isConrrect = isPermission()

if isConrrect == false then
        ngx.say(fun:resJson(ngx.HTTP_FORBIDDEN,'Permission Denied',nil))
	return
end

--ngx.say("request successful!")

