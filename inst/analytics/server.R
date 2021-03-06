shinyServer(function(input, output, session) {

	# source shared functions
	source(file.path(r_path,"base/init.R"), encoding = r_encoding, local = TRUE)
	source(file.path(r_path,"base/radiant.R"), encoding = r_encoding, local = TRUE)

  # for shiny-server
  if (!"package:radiant" %in% search()) {
    if (r_path == "..") {
      for (file in list.files("../../R",
          pattern="\\.(r|R)$",
          full.names = TRUE)) {

        source(file, encoding = r_encoding, local = TRUE)
      }
    } else {
      radiant::copy_all(radiant)
      set_class <- radiant::set_class
    }
  } else {
    copy_from(radiant, state_init, state_single, state_multiple)
  }

	# source data & app tools from base
	for (file in list.files(c(file.path(r_path,"base/tools/app"),
	    									 file.path(r_path,"base/tools/data")),
												 pattern="\\.(r|R)$", full.names = TRUE))
	  source(file, encoding = r_encoding, local = TRUE)

	# source analysis tools from quant app
	for (file in list.files(file.path(r_path,"quant/tools/analysis"),
	    									 pattern="\\.(r|R)$", full.names = TRUE))
	  source(file, encoding = r_encoding, local = TRUE)

  # source analysis tools from marketing app
  for (file in list.files(file.path(r_path,"marketing/tools/analysis"),
                         pattern="\\.(r|R)$", full.names = TRUE))
    source(file, encoding = r_encoding, local = TRUE)

	# source additional analysis tools for analytics app
  # for (file in list.files(c("tools/analysis"),
  #     									 pattern="\\.(r|R)$", full.names = TRUE))
	 #  source(file, encoding = r_encoding, local = TRUE)

  # save state on refresh or browser close
  saveStateOnRefresh(session)

})
