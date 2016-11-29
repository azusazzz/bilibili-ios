function  URLString()
	local  h = UIScreen:mainScreen():bounds().height;
	local  w = UIScreen:mainScreen():bounds().width;
	local  s = UIScreen:mainScreen():scale();
	return string.format("http://app.bilibili.com/x/splash?build=3390&channel=appstore&height=%.0f&plat=1&width=%.0f",h*s,w*s);
end