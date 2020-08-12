rule extract_collections:
    input:
        "imeta/qu/raw_collections.txt"
    output:
        temp("imeta/qu/collections.txt")
    message:
        "Parsing imeta qu output"
    threads:
        3
    resources:
        mem_mb = lambda wildcards, attempt: min(128 * attempt, 768),
        time_min = lambda wildcards, attempt: attempt * 60
    log:
        "logs/imeta/qu/extraction.log"
    wrapper:
        f"{git}/bio/iRODS/extract_collections"


rule imeta_to_yaml:
    input:
        "imeta/ls/raw_metadata.txt"
    output:
        temp("imeta/ls/metadata.yaml")
    message:
        "Formatting imeta ls output to standard yaml"
    threads:
        1
    resources:
        mem_mb = lambda wildcards, attempt: min(512 * attempt, 1024),
        time_min = lambda wildcards, attempt: attempt * 60
    log:
        "logs/imeta/ls/yaml.log"
    wrapper:
        f"{git}/bio/iRODS/yaml"


rule imeta_extract_fields:
    input:
        "imeta/ls/metadata.yaml"
    output:
        "imeta/collections.tsv"
    message:
        "Extracting fields of interest from yaml file"
    threads:
        1
    resources:
        mem_mb = lambda wildcards, attempt: min(512 * attempt, 1024),
        time_min = lambda wildcards, attempt: attempt * 60
    params:
        attributes = config.get(
            "imeta_ls",
            ["datafileId", "datafileName", "datasetId",
             "datasetName", "sampleType", "protocol",
             "sampleId", "species", "technicalPlatform"]
        )
    log:
        "logs/imeta/ls/extraction.log"
    wrapper:
        f"{git}/bio/iRODS/extract_metadata"
