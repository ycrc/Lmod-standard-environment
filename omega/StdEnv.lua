add_property("lmod", "sticky")
--
local rootpath = "/gpfs/loomis/home.omega/apps/hpc.rhel7"
local moduledirs = {
    "Modules",
    "Modules.rhel6"
}

for i = #moduledirs, 1, -1 do
    prepend_path("MODULEPATH", pathJoin(rootpath, moduledirs[i]))
end

local home = os.getenv("HOME")
local scratch = home:gsub("/home", "/gpfs/loomis/scratch60")
setenv ("SCRATCH", scratch)
local project = home:gsub("/home", "/gpfs/loomis/project")
setenv ("LOOMIS_PROJECT", project)

-- Add module tracking, addtl paths
setenv ("LMOD_PACKAGE_PATH", "/gpfs/loomis/home.omega/apps/hpc.rhel7")
prepend_path("PATH", "/apps/bin")
-- File for deprecation messages
setenv ("LMOD_ADMIN_FILE", pathJoin("/gpfs/loomis/home.omega/apps/hpc.rhel7","admin.list"))
