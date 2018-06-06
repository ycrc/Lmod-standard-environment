# Lmod-standard-environment
standard module and module tracking

Make sure to copy the appropriate cluster StdEnv.lua and SitePackage.lua to the right place for each cluster:

| Cluster | Location        |
|---------|-----------------|
| Farnam  | /gpfs/ysm/apps/hpc.rhel7 |
| Omega   | /apps/hpc.rhel7 |
| Ruddle  | /gpfs/ycga/apps |
| Grace   | /apps/hpc.rhel7 |
| Farnam  | /gpfs/ysm/apps  |

The included sample logrotate configuration, moduleUsage, should be copied to `/etc/logrotate.d/` on monitor1 on Farnam.

SitePackage.lua should be the same on all clusters.

The Farnam & Ruddle StdEnv modules also set `LMOD_ADMIN_FILE` for [deprecating modules](https://lmod.readthedocs.io/en/latest/140_deprecating_modules.html).

