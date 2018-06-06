add_property("lmod", "sticky")
--
local rootpath = "/apps/hpc.rhel7"
local moduledirs = {
    "Modules",
    "Modules.rhel6"
}

for i = #moduledirs, 1, -1 do
    prepend_path("MODULEPATH", pathJoin(rootpath, moduledirs[i]))
end

-- Add module tracking, addtl paths
setenv ("LMOD_PACKAGE_PATH", "/apps/hpc.rhel7")
prepend_path("PATH", "/apps/bin")
-- File for deprecation messages
setenv ("LMOD_ADMIN_FILE", pathJoin("/apps/hpc.rhel7","admin.list"))
