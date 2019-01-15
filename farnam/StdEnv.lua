add_property("lmod", "sticky")
-- Set module path
local rootpath = "/gpfs/ysm/apps/modules"
local moduledirs = {
    "base", "bio", "cae", "chem", "compiler", "data", "debugger", "devel",
    "geo", "ide", "lang", "lib", "math", "mpi", "numlib", "perf", "phys",
    "system", "toolchain", "tools", "vis"
}

for i = #moduledirs, 1, -1 do
    prepend_path("MODULEPATH", pathJoin(rootpath, moduledirs[i]))
end

-- project & scratch env vars
local home = os.getenv("HOME")
local scratch = home:gsub("/home", "/gpfs/ysm/scratch60")
setenv ("YSM_SCRATCH", scratch)
local project = home:gsub("/home", "/gpfs/ysm/project")
setenv ("YSM_PROJECT", project)

-- Add module tracking, addtl paths
setenv ("LMOD_PACKAGE_PATH", "/gpfs/ysm/apps")
prepend_path("PATH", "/gpfs/ysm/bin")

-- File for depreciation messages
setenv ("LMOD_ADMIN_FILE", pathJoin(rootpath,"admin.list"))

-- Set default conda install directory to be in project
prepend_path("CONDA_ENVS_PATH", pathJoin(project, "conda_envs"))
