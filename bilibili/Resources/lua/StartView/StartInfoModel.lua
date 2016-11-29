require "StartInfoRequest"

waxClass{"StartInfoModel",NSObject}
function init( self )
	self.super:init();
	cachesPath = NSCacheDirectory.."/starView_data";
	local bl = NSFileManager:defaultManager():fileExistsAtPath(cachesPath);
	self.currentStartPage  = nil;
	if(bl)then
			local file = io.open(cachesPath,"r");
			io.input(file);
			local  data = unserialize(io.read("*a"))["data"];
			io.close(file);


			local  currentTime = NSDate:dateWithTimeIntervalSinceNow(0):timeIntervalSince1970();
            -- currentTime = 1479743930;
			-- print(currentTime);
			for k,v in pairs(data) do
				if(v["end_time"]>currentTime and v["start_time"]<currentTime)then
					if SDWebImageManager:sharedManager():diskImageExistsForURL(NSURL:URLWithString(v["image"])) then
                        self.currentStartPage = v;
                    end
				end
			end
	end
	
	update(self);
	return self;
end

function  update(self)
	local  url = URLString();
	-- print(url)
	-- print(cachesPath);
	wax.http.get{url,callback = function (body,request)
		print(request:statusCode());
		if(type(body)=="table")then
			local file = io.open(cachesPath,"w");
			io.output(file);
			io.write(serialize(body));
			io.close(file);

            local  currentTime = NSDate:dateWithTimeIntervalSinceNow(0):timeIntervalSince1970();
            --currentTime = 1479743930;
            for k,v in pairs(body["data"]) do
                if(v.end_time>currentTime) then
                    UIImageView:init():sdUNDERxLINEsetImageWithURL(NSURL:URLWithString(v["image"]));
                end
            end
		end
		
	end}
end


--序列化一个Table  
function serialize(obj)  
    local lua = ""  
    local t = type(obj)  
    if t == "number" then  
        lua = lua .. obj  
    elseif t == "boolean" then  
        lua = lua .. tostring(obj)  
    elseif t == "string" then  
        lua = lua .. string.format("%q", obj)  
    elseif t == "table" then  
        lua = lua .. "{\n"  
    for k, v in pairs(obj) do  
        lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"  
    end  
    local metatable = getmetatable(obj)  
        if metatable ~= nil and type(metatable.__index) == "table" then  
        for k, v in pairs(metatable.__index) do  
            lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"  
        end  
    end  
        lua = lua .. "}"  
    elseif t == "nil" then  
        return nil  
    else  
        error("can not serialize a " .. t .. " type.")  
    end  
    return lua  
end  

function unserialize(lua)  
    local t = type(lua)  
    if t == "nil" or lua == "" then  
        return nil  
    elseif t == "number" or t == "string" or t == "boolean" then  
        lua = tostring(lua)  
    else  
        error("can not unserialize a " .. t .. " type.")  
    end  
    lua = "return " .. lua  
    local func = loadstring(lua)  
    if func == nil then  
        return nil  
    end  
    return func()  
end  