# Lmod-standard-environment
standard module and module tracking

Make sure to copy the appropriate cluster StdEnv.lua and SitePackage.lua to the right place for each cluster:

| Cluster  | Location                     |
|----------|------------------------------|
| Grace    | /gpfs/lommis/apps/hpc.rhel7 / /vast/palmer/apps/avx.grace|
| McCleary | /vast/palmer/apps/avx2       |
| Farnam   | /gpfs/ysm/apps               |
| Ruddle   | /gpfs/ycga/apps/hpc          |
| Milgram  | /gpfs/milgram/apps/hpc.rhel7 |

The included sample logrotate configuration, moduleUsage, should be copied to `/etc/logrotate.d/` on monitor1 on Farnam.

SitePackage.lua should be the same on all clusters.

The Farnam & Ruddle StdEnv modules also set `LMOD_ADMIN_FILE` for [deprecating modules](https://lmod.readthedocs.io/en/latest/140_deprecating_modules.html).

