"""
While other .smk files contains rules and pure snakemake instructions, this
one gathers all the python instructions surch as config mappings or input
validations.
"""

from snakemake.utils import validate   # Check Yaml/TSV formats

# Snakemake-Wrappers version
wrapper_version = "https://raw.githubusercontent.com/snakemake/snakemake-wrappers/0.64.0"
# github prefix
git = "https://raw.githubusercontent.com/tdayris/snakemake-wrappers/Unofficial"
