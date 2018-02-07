# Lmod-standard-environment
standard module and module tracking

Make sure to copy the appropriate cluster StdEnv.lua and SitePackage.lua to the right place for each cluster:

| Cluster | Location        |
|---------|-----------------|
| Omega   | /apps/hpc.rhel7 |
| Ruddle  | /gpfs/ycga/apps |
| Grace   | /apps/hpc.rhel7 |

The included sample logrotate configuration, moduleUsage, should be copied to `/etc/logrotate.d/` on logger.

SitePackage.lua should be the same on all clusters.
