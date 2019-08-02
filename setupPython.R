use_condaenv("base", conda = "/home/calvinw/miniconda3/bin/conda")
matplotlib <- import("matplotlib")
matplotlib$use("Agg", force = TRUE)
py_config()
