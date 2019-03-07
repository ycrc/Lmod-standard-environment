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
if ( home ~= nil ) then
    scratch = home:gsub("/home", "/gpfs/loomis/scratch60")
    setenv ("LOOMIS_SCRATCH", scratch)
    project = home:gsub("/home", "/gpfs/loomis/project")
    setenv ("LOOMIS_PROJECT", project)
end

-- For Hyperthreading protection
setenv ("SLURM_HINT", "nomultithread")

-- Add module tracking, addtl paths
setenv ("LMOD_PACKAGE_PATH", "/gpfs/loomis/apps/hpc.rhel7")
prepend_path("PATH", "/gpfs/loomis/apps/bin")

-- File for deprecation messages
setenv ("LMOD_ADMIN_FILE", pathJoin("/gpfs/loomis/apps/hpc.rhel7","admin.list"))

-- Set default conda install directory to be in project
prepend_path("CONDA_ENVS_PATH", pathJoin(project, "conda_envs"))
