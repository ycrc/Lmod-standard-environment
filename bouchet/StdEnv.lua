add_property("lmod", "sticky")


prepend_path("MODULEPATH", "/apps/software/2022b/modules/all")
prepend_path("MODULEPATH", "/apps/software/2024a/modules/all")

-- Standard Environment Variables
setenv ("SQUEUE_FORMAT", "%.18i %.9P %.8j %.8u %.9a %.2t %.16V %.10M %.10l %.5D %.5C %.10m %.10b %.10f %.10p %R")
setenv ("SACCT_FORMAT", "jobname,jobid,JobIDRaw,user,account,partition,Start,End,Elapsed,MaxVM,AveVM,ReqMem,NNodes,NTasks,NCPUS,ReqTres,ExitCode,State,NodeList")
setenv ("OMPI_MCA_oob_tcp_if_include", "10.181.0.0/16")

-- For Hyperthreading protection
setenv ("SLURM_HINT", "nomultithread")

-- Set default to interactive partition
setenv ("SALLOC_PARTITION", "devel")

-- Enable hist file time formats
setenv ("HISTTIMEFORMAT", "%Y-%m-%d %T ")
-----
-- Lmod Options
-----

-- Add module tracking, addtl paths
setenv ("LMOD_PACKAGE_PATH", pathJoin(vast_prefix, "/apps/lmod"))

-- File for deprecation messages
setenv ("LMOD_ADMIN_FILE", pathJoin(vast_prefix, "/apps/lmod/", "admin.list"))

-- Make module searches sort case insensitive
setenv ("LMOD_CASE_INDEPENDENT_SORTING", "yes")

-- User Scripts
prepend_path("PATH", "/apps/bin")

-- set default path for XDG to be non-empty
append_path('XDG_DATA_DIRS', '/usr/local/share:/usr/share')

