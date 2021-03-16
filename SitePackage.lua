require("strict")
require("lmod_system_execute")
local hook    = require("Hook")
local uname   = require("posix").uname
local cosmic  = require("Cosmic"):singleton()
local FrameStk  = require("FrameStk")
local syshost = cosmic:value("LMOD_SYSHOST")

-- By using the hook.register function, this function "load_hook" is called
-- ever time a module is loaded with the file name and the module name.

local s_msgA = {}

function load_hook(t)
   -- the arg t is a table:
   --     t.modFullName:  the module full name: (i.e: gcc/4.7.2)
   --     t.fn:           The file name: (i.e /apps/modulefiles/Core/gcc/4.7.2.lua)

   if (mode() ~= "load") then return end
   local user        = os.getenv("USER")
   local grps  = capture("groups")
   local defaultGroup = ''
   for g in grps:split("[ \n]") do
        defaultGroup = g
        break
   end
   if ((defaultGroup == 'lsprog') or (defaultGroup == 'hpcprog') or (defaultGroup == 'support')) then return end
   local group       = os.getenv("SLURM_JOB_ACCOUNT") or defaultGroup
   local jobid       = os.getenv("SLURM_ARRAY_JOB_ID") or os.getenv("SLURM_JOB_ID") or "na"
   local host        = syshost or uname("%n")
   local currentTime = epoch()

   local frameStk = FrameStk:singleton()
   -- did the user load it or was it a dependency?
   local userload = (frameStk:atTop()) and "yes" or "no"
   -- the name the user used in their module load command
   local requestedas = frameStk:userName()

   local msg         = string.format("user=%s group=%s module=%s path=%s host=%s jobid=%s userload=%s requestedas=%s time=%f",
                                     user, group, t.modFullName, t.fn, host, jobid,
                                     userload, requestedas, currentTime)
    
   local a           = s_msgA
   a[#a+1]           = msg
end

hook.register("load",load_hook)



function report_loads()

   local sys         = os.getenv("LMOD_sys") or "Linux"
   if (sys == "Linux") then
      local a = s_msgA
      for i = 1,#a do
         local msg = a[i]
         lmod_system_execute("logger -t ModuleUsageTracking -p local0.info " .. msg)
      end
   end

end


ExitHookA.register(report_loads)

