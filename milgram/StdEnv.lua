add_property("lmod", "sticky")
-- Set module path
local common_prefix = "/gpfs/milgram"
local rootpath = pathJoin(common_prefix, "/apps/hpc.rhel7/modules")
local moduledirs = {
    "base", "bio", "cae", "chem", "compiler", "data", "debugger", "devel",
    "geo", "ide", "lang", "lib", "math", "mpi", "numlib", "perf", "phys",
    "system", "toolchain", "tools", "vis"
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
setenv ("SCRATCH", scratch)
setenv ("PROJECT", project)

-- Standard environment variables
setenv ("SQUEUE_FORMAT", "%18i %11P %18j %6u %.2t %.10M %.10l %.5D %.5C %.10m %R")

-----
-- Lmod Options
-----

-- Add module tracking, addtl paths
setenv      ("LMOD_PACKAGE_PATH", pathJoin(common_prefix, "/apps"))
prepend_path("PATH",              pathJoin(common_prefix, "/apps/bin"))

-- File for deprecation messages
setenv ("LMOD_ADMIN_FILE", pathJoin(rootpath, "admin.list"))

-- Use module cache for loads
setenv ("LMOD_CACHED_LOAD", "yes")

-- Make module searches sort case insensitive
setenv ("LMOD_CASE_INDEPENDENT_SORTING", "yes")

-- Set default conda install directory to be in project
prepend_path("CONDA_ENVS_PATH", pathJoin(project, "conda_envs"))
prepend_path("CONDA_PKGS_DIRS", pathJoin(project, "conda_pkgs"))

