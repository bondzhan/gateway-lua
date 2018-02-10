
local template=require "resty.template";
ngx.say("hi bond ".. ngx.var.file_path);
template.render(ngx.var.file_path..".html");

