add_property("lmod", "sticky")
--
local rootpath = "/gpfs/loomis/apps/avx/modules"
local moduledirs = {
    "base", "bio", "cae", "chem", "compiler", "data", "debugger", "devel",
    "geo", "ide", "lang", "lib", "math", "mpi", "numlib", "perf", "phys",
    "system", "toolchain", "tools", "vis", "restricted"
}

for i = #moduledirs, 1, -1 do
    prepend_path("MODULEPATH", pathJoin(rootpath, moduledirs[i]))
end

-- Standard Environment Variables
local home = os.getenv("HOME")
if ( home ~= nil ) then
    scratch = home:gsub("/home", "/gpfs/loomis/scratch60")
    setenv ("LOOMIS_SCRATCH", scratch)
    project = home:gsub("/home", "/gpfs/loomis/project")
    setenv ("LOOMIS_PROJECT", project)
end
setenv ("SQUEUE_FORMAT", "%18i %11P %18j %4u %.2t %.10M %.10l %.5D %.5C %.10m %R")

-- For Hyperthreading protection
setenv ("SLURM_HINT", "nomultithread")

-- Add module tracking, addtl paths
setenv ("LMOD_PACKAGE_PATH", "/gpfs/loomis/apps/")
prepend_path("PATH", "/gpfs/loomis/apps/bin")

-- File for deprecation messages
setenv ("LMOD_ADMIN_FILE", pathJoin("/gpfs/loomis/apps/hpc.rhel7","admin.list"))

-- Set default conda install directory to be in project
prepend_path("CONDA_ENVS_PATH", pathJoin(project, "conda_envs"))
