require "StartView"
local p = "/Users/CXH/Library/Developer/CoreSimulator/Devices/8709471F-8B51-4A93-8E1C-88DC4E993E7A/data/Containers/Data/Application/5E8DC325-7ED5-446C-95E6-454783D956F8/Library/Caches/Resources/lua/"
local m_package_path = package.path
package.path = string.format("%s?.lua;%s?/init.lua;%s",p, p,m_package_path)
print(package.path)
print(package.cpath)
UIApplication:sharedApplication():keyWindow():addSubview(StartView:init());
