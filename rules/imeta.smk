rule gather_collections:
    output:
        temp("imeta/qu/raw_collections.txt")
    message:
        "Gathering collection list with iRODS command"
    threads:
        1
    resources:
        mem_mb = lambda wildcards, attempt: min(128 * attempt, 768),
        time_min = lambda wildcards, attempt: attempt * 60
    params:
        extra = config["params"].get("imeta_qu_extra", "-d"),
        kwords = config.get("imeta_qu", {"protocol": "mRNA%"})
    log:
        "logs/imeta/qu/raw.log"
    wrapper:
        f"{git}/bio/iRODS/imeta_qu"


rule gather_metadata:
    input:
        "imeta/qu/collections.txt"
    output:
        temp("imeta/ls/raw_metadata.txt")
    message:
        "Gather metadata from multiple collections"
    threads:
        1
    resources:
        mem_mb = lambda wildcards, attempt: min(128 * attempt, 768),
        time_min = lambda wildcards, attempt: attempt * 60
    params:
        extra = config["params"].get("imeta_ls_extra", "-d")
    log:
        "logs/imeta/ls/raw.log"
    wrapper:
        f"{git}/bio/iRODS/imeta_ls"
