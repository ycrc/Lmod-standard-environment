# Lmod-standard-environment
standard module and module tracking

Make sure to copy the appropriate cluster StdEnv.lua and SitePackage.lua to the right place for each cluster:

| Cluster  | Location                     |
|----------|------------------------------|
| Grace    | /vast/palmer/apps/avx2/StdEnv.grace.lua|
| McCleary | /vast/palmer/apps/avx2/StdEnv.mccleary.lua|
| Milgram  |  /gpfs/milgram/apps/hpc/StdEnv.milgram.lua|


SitePackage.lua should be the same on all clusters.

The StdEnv modules also set `LMOD_ADMIN_FILE` for [deprecating modules](https://lmod.readthedocs.io/en/latest/140_deprecating_modules.html).

