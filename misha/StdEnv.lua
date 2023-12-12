add_property("lmod", "sticky")

-- Available disks
local vast_prefix = "/vast/palmer"
local radev_prefix = "/gpfs/radev"

-- Set module path
local rootpath = pathJoin(vast_prefix, "/apps/avx2/modules")
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
local grps = capture("groups")
local defaultGroup = ''
for g in grps:split("[ \n]") do
    defaultGroup = g
    break
end
local scratch = pathJoin(radev_prefix, "/scratch", defaultGroup, os.getenv("USER"))
local project = pathJoin(radev_prefix, "/project",   defaultGroup, os.getenv("USER"))
setenv("SCRATCH", scratch)
setenv("PROJECT", project)

-----
-- Lmod Options
-----

-- Add module tracking, addtl paths
setenv("LMOD_PACKAGE_PATH", pathJoin(vast_prefix, "/apps/avx2"))

-- File for deprecation messages
setenv("LMOD_ADMIN_FILE", pathJoin(vast_prefix, "/apps/avx2", "admin.list"))

-- Make module searches sort case insensitive
setenv("LMOD_CASE_INDEPENDENT_SORTING", "yes")

-- Use module cache for loads
setenv("LMOD_CACHED_LOAD", "yes")

-- Functionally disable user cache
setenv("LMOD_SHORT_TIME", 86400)

-- Make module searches sort case insensitive
setenv("LMOD_CASE_INDEPENDENT_SORTING", "yes")

-----
-- Standard environment variables
-----

setenv ("CLUSTER", "misha")
prepend_path("PATH", pathJoin(vast_prefix, "/apps/bin"))

setenv("SQUEUE_FORMAT", "%.18i %.9P %.8j %.8u %.9a %.2t %.16V %.10M %.10l %.5D %.5C %.10m %.10b %.10f %.10p %R")
setenv("SACCT_FORMAT", "jobname,jobid,JobIDRaw,user,account,partition,Start,End,Elapsed,MaxVM,AveVM,ReqMem,NNodes,NTasks,NCPUS,ReqTres,ExitCode,State,NodeList")

-- MPI env variables
setenv("OMPI_MCA_btl_tcp_if_include", "cluster")
setenv("OMPI_MCA_oob_tcp_if_include", "cluster")
setenv("UCX_NET_DEVICES", "cluster")

-- set default XDG_DATA_DIR
append_path('XDG_DATA_DIRS', '/usr/local/share:/usr/share')

-- For Hyperthreading protection
setenv("SLURM_HINT", "nomultithread")

-- Set default to interactive partition
setenv("SALLOC_PARTITION", "devel")

-- Enable hist file time formats
setenv("HISTTIMEFORMAT", "%Y-%m-%d %T ")

-- Set default conda install directory to be in project
-- prepend_path("CONDA_ENVS_PATH", pathJoin(project, "conda_envs"))
-- prepend_path("CONDA_PKGS_DIRS", pathJoin(project, "conda_pkgs"))
