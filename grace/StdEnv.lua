add_property("lmod", "sticky")
-- Set module path
local common_prefix = "/gpfs/loomis"
local rootpath = pathJoin(common_prefix, "/apps/avx/modules")
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
local project = pathJoin("/gpfs/gibbs", "/project",   defaultGroup, os.getenv("USER"))
local palmer_scratch = pathJoin("/vast/palmer/scratch", defaultGroup, os.getenv("USER"))
setenv ("LOOMIS_SCRATCH", scratch)
setenv ("LOOMIS_PROJECT", project)
setenv ("PALMER_SCRATCH", palmer_scratch)

-- Standard Environment Variables
setenv ("SQUEUE_FORMAT", "%18i %11P %18j %6u %.2t %.10M %.10l %.5D %.5C %.10m %R")
setenv ("SALLOC_PARTITION", "interactive")

-- For Hyperthreading protection
setenv ("SLURM_HINT", "nomultithread")

-- Extended History Formatting --
setenv ("HISTTIMEFORMAT", "%Y-%m-%d %T ")

-----
-- Lmod Options
-----

setenv ("LMOD_SHORT_TIME", 86400)

-- Add module tracking, addtl paths
setenv      ("LMOD_PACKAGE_PATH", "/vast/palmer/apps/avx.grace")
prepend_path("PATH",              pathJoin(common_prefix, "/bin" ))

-- File for deprecation messages
setenv ("LMOD_ADMIN_FILE", pathJoin("/vast/palmer/apps/avx.grace", "admin.list"))

-- Make module searches sort case insensitive
setenv ("LMOD_CASE_INDEPENDENT_SORTING", "yes")

-- Set default conda install directory to be in project
prepend_path("CONDA_ENVS_PATH", pathJoin(project, "conda_envs"))
prepend_path("CONDA_PKGS_DIRS", pathJoin(project, "conda_pkgs"))
