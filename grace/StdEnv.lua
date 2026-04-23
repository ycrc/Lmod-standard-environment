add_property("lmod", "sticky")

local cluster = os.getenv("CLUSTER")
local home = os.getenv("HOME")
local user = os.getenv("USER")

-- Available disks
local palmer_prefix = "/vast/palmer"
local gibbs_prefix = "/gpfs/gibbs"

-- Project & Scratch
local grps = capture("groups")
local defaultGroup = ""
for g in grps:split("[ \n]") do
    defaultGroup = g
    break
end
local scratch = pathJoin(palmer_prefix, "/scratch", defaultGroup, user)
local project = pathJoin(gibbs_prefix, "/project", defaultGroup, user)
setenv("PALMER_SCRATCH", scratch)
setenv("GIBBS_PROJECT", project)

----
-- Standard Environment Variables
----

-- User Scripts
prepend_path("PATH", "/apps/bin")

-- Slurm
setenv("SQUEUE_FORMAT", "%.18i %.9P %.8j %.8u %.9a %.2t %.16V %.10M %.10l %.5D %.5C %.10m %.10b %.10f %.10p %R")
setenv("SACCT_FORMAT", "jobname,jobid,JobIDRaw,user,account,partition,Start,End,Elapsed,MaxVM,AveVM,ReqMem,NNodes,NTasks,NCPUS,ReqTres,ExitCode,State,NodeList")

-- Hyperthreading protection
setenv("SLURM_HINT", "nomultithread")

-- Set default to interactive partition
setenv("SALLOC_PARTITION", "devel")

-- Enable hist file time format
setenv("HISTTIMEFORMAT", "%Y-%m-%d %T ")

-- set default XDG_DATA_DIR
append_path("XDG_DATA_DIRS", "/usr/local/share:/usr/share")

-- Set default conda install directory to be in home, with project fall-back for envs
prepend_path("CONDA_ENVS_PATH", pathJoin(home, ".conda/envs"))
append_path("CONDA_ENVS_PATH", pathJoin(project, "conda_envs"))
setenv("CONDA_PKGS_DIRS",  pathJoin(home, ".conda/pkgs"))

-- MPI
setenv("OMPI_MCA_oob_tcp_if_include", "cluster")

if (cluster == "mccleary") then
    setenv("OMPI_MCA_btl_tcp_if_include", "cluster")
    setenv("UCX_NET_DEVICES", "cluster")
end

-- default browser
setenv("BROWSER", "/apps/bin/firefox")
