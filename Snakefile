import snakemake.utils  # Load snakemake API
import sys              # System related operations

# Python 3.8 is required
if sys.version_info < (3, 8):
    raise SystemError("Please use Python 3.8 or later.")

# Snakemake 5.14.0 at least is required
snakemake.utils.min_version("5.20.1")


include: "rules/common.smk"
include: "rules/imeta.smk"
include: "rules/reformat.smk"


workdir: config["workdir"]
container: "docker://continuumio/miniconda3:4.4.10"


rule all:
    input:
        "imeta/collections.tsv"
    message:
        "Finishing iRODS collection pipeline"
