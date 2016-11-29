
package.path = NSCacheDirectory.."/Resources/lua/?.lua;"..package.path;
local  path = NSCacheDirectory.."/Resources/lua";
local files = NSFileManager:defaultManager():contentsOfDirectoryAtPath_error(path,nil);

if(type(files) == "table")then
for k,v in pairs(files) do
    local lpath = path.."/"..v;
    if(not wax.filesystem.isFile(lpath))then
		package.path = lpath.."/?.lua;"..package.path;
    end
end
end

require "StartView"
UIApplication:sharedApplication():keyWindow():addSubview(StartView:init());
