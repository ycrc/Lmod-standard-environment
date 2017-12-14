add_property("lmod", "sticky")
--
local rootpath = "/apps"
local moduledirs = {
    "hpc.rhel7/Modules",
    "hpc.rhel6/Modules"
}

for i = #moduledirs, 1, -1 do
    prepend_path("MODULEPATH", pathJoin(rootpath, moduledirs[i]))
end
--

setenv ("LMOD_PACKAGE_PATH", "/gpfs/loomis/apps/hpc.rhel7")
prepend_path("PATH", "/apps/bin")
