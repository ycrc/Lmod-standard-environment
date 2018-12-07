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

local home = os.getenv("HOME")
local scratch = home:gsub("/home", "/gpfs/loomis/scratch60")
setenv ("LOOMIS_SCRATCH", scratch)
local project = home:gsub("/home", "/gpfs/loomis/project")
setenv ("LOOMIS_PROJECT", project)

-- Add module tracking, addtl paths
setenv ("LMOD_PACKAGE_PATH", "/gpfs/loomis/apps/hpc.rhel7")
prepend_path("PATH", "/apps/bin")
-- File for deprecation messages
setenv ("LMOD_ADMIN_FILE", pathJoin("/gpfs/loomis/apps/hpc.rhel7","admin.list"))
