add_property("lmod", "sticky")
-- Set module path
local common_prefix = "/gpfs/loomis"
local rootpath = pathJoin(common_prefix, "/apps/avx/modules")
local moduledirs = {
    "base", "bio", "cae", "chem", "compiler", "data", "debugger", "devel",
    "geo", "ide", "lang", "lib", "math", "mpi", "numlib", "perf", "phys",
    "system", "toolchain", "tools", "vis", "restricted"
}

for i = #moduledirs, 1, -1 do
    prepend_path("MODULEPATH", pathJoin(rootpath, moduledirs[i]))
end

-- project & scratch env vars
local grps  = capture("groups")
local defaultGroup = ''
for g in grps:split("[ \n]") do
    defaultGroup = g
    break
end
local scratch = pathJoin(common_prefix, "/scratch60", defaultGroup, os.getenv("USER"))
local project = pathJoin(common_prefix, "/project",   defaultGroup, os.getenv("USER"))
setenv ("LOOMIS_SCRATCH", scratch)
setenv ("LOOMIS_PROJECT", project)

-- Add module tracking, addtl paths
setenv      ("LMOD_PACKAGE_PATH", pathJoin(common_prefix, "/apps"))
prepend_path("PATH",              pathJoin(common_prefix, "/bin" ))

-- File for depreciation messages
setenv ("LMOD_ADMIN_FILE", pathJoin(common_prefix, "/apps/hpc.rhel7", "admin.list"))

-- Standard Environment Variables
setenv ("SQUEUE_FORMAT", "%18i %11P %18j %4u %.2t %.10M %.10l %.5D %.5C %.10m %R")

-- For Hyperthreading protection
setenv ("SLURM_HINT", "nomultithread")

-- Set default conda install directory to be in project
prepend_path("CONDA_ENVS_PATH", pathJoin(project, "conda_envs"))
prepend_path("CONDA_PKGS_DIRS", pathJoin(project, "conda_pkgs"))
