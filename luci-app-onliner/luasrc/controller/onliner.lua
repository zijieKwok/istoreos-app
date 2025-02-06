module("luci.controller.onliner",package.seeall)
nixio=require"nixio"

function index()
	entry({"admin", "status", "onliner"}, template("onliner/onliner"), _("在线用户"))
	entry({"admin", "status", "onliner", "setnlbw"}, call("set_nlbw"))
end

function set_nlbw()
	if nixio.fs.access("/var/run/onsetnlbw") then
		nixio.fs.writefile("/var/run/onsetnlbw","1");
	else
		io.popen("/usr/share/onliner/setnlbw.sh &")
	end
	luci.http.prepare_content("application/json")
	luci.http.write('')
end
