add_property("lmod", "sticky")
-- Set module path
local common_prefix = "/gpfs/ysm"
local rootpath = pathJoin(common_prefix, "/apps/modules")
local moduledirs = {
    "base", "bio", "cae", "chem", "compiler", "data", "debugger", "devel",
    "geo", "ide", "lang", "lib", "math", "mpi", "numlib", "perf", "phys",
    "system", "toolchain", "tools", "vis", "restricted"
}

local modulepath = pathJoin(rootpath, moduledirs[1])
for i = 2, #moduledirs, 1 do
    modulepath = modulepath .. ":" .. pathJoin(rootpath, moduledirs[i])
end
prepend_path("MODULEPATH", modulepath)

-- project & scratch env vars
local grps  = capture("groups")
local defaultGroup = ''
for g in grps:split("[ \n]") do
    defaultGroup = g
    break
end
local scratch = pathJoin(common_prefix, "/scratch60", defaultGroup, os.getenv("USER"))
local project = pathJoin(common_prefix, "/project",   defaultGroup, os.getenv("USER"))
setenv ("YSM_SCRATCH", scratch)
setenv ("YSM_PROJECT", project)

-- Add module tracking, addtl paths
setenv      ("LMOD_PACKAGE_PATH", pathJoin(common_prefix, "/apps"))
prepend_path("PATH",              pathJoin(common_prefix, "/bin" ))

-- File for deprecation messages
setenv ("LMOD_ADMIN_FILE", pathJoin(rootpath,"admin.list"))

-- Standard Environment Variables
setenv ("SQUEUE_FORMAT", "%18i %11P %18j %6u %.2t %.10M %.10l %.5D %.5C %.10m %R")

-- For Hyperthreading protection
setenv ("SLURM_HINT", "nomultithread")

-- Set default conda install directory to be in project
prepend_path("CONDA_ENVS_PATH", pathJoin(project, "conda_envs"))
prepend_path("CONDA_PKGS_DIRS", pathJoin(project, "conda_pkgs"))
