library("reticulate")
matplotlib <- import("matplotlib", convert = TRUE)

# check to see if a backend has already been initialized. if so, we
# need to switch backends; otherwise, we can simply request to use a
# specific one when the backend is initialized later
sys <- import("sys", convert = FALSE)
if ("matplotlib.backends" %in% names(sys$modules)) {
  matplotlib$pyplot$switch_backend("agg")
} else { 
  matplotlib$use("agg", warn = FALSE, force = TRUE)
}
