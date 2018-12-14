add_property("lmod", "sticky")
-- Set module path
local rootpath = "/gpfs/milgram/apps/hpc.rhel7/modules"
local moduledirs = {
    "base", "bio", "cae", "chem", "compiler", "data", "debugger", "devel",
    "geo", "ide", "lang", "lib", "math", "mpi", "numlib", "perf", "phys",
    "system", "toolchain", "tools", "vis"
}

for i = #moduledirs, 1, -1 do
    prepend_path("MODULEPATH", pathJoin(rootpath, moduledirs[i]))
end

-- Standard environment variables
prepend_path("PATH", pathJoin(os.getenv("HOME"),".ycrc/bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(os.getenv("HOME"),".ycrc/lib"))

-- Add module tracking, addtl paths
setenv ("LMOD_PACKAGE_PATH", "/gpfs/milgram/apps")
prepend_path("PATH", "/gpfs/milgram/apps/bin")

-- File for depreciation messages
setenv ("LMOD_ADMIN_FILE", pathJoin(rootpath,"admin.list"))

-- Use module cache for loads
setenv ("LMOD_CACHED_LOAD", "yes")

