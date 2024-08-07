#' plot_iblocks
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
plot_iblocks_1 <- function(
    x = NULL,
    n_TrtGen = NULL,
    n_Reps = NULL,
    sizeIblocks,
    iBlocks = NULL,
    layout = 1,
    stacked = "vertical",
    planter = "serpentine",
    l = 1) {
  site <- l
  locations <- factor(x$fieldBook$LOCATION, levels = unique(x$fieldBook$LOCATION))
  loc_levels <- levels(locations)
  nlocs <- length(locations)
  newBooksLocs <- vector(mode = "list", length = nlocs)
  countLocs <- 1
  books0 <- list(NULL)
  books01 <- list(NULL)
  books02 <- list(NULL)
  books1 <- list(NULL)
  books2 <- list(NULL)
  books3 <- list(NULL)
  books4 <- list(NULL)
  books5 <- list(NULL)
  books6 <- list(NULL)
  books7 <- list(NULL)
  books21 <- list(NULL)
  for (locs in loc_levels) {
    NewBook <- x$fieldBook |>
      dplyr::filter(LOCATION == locs)
    plots <- NewBook$PLOT
    w <- 1:(sizeIblocks * n_Reps)
    u <- seq(1, length(w), by = sizeIblocks)
    v <- seq(sizeIblocks, length(w), by = sizeIblocks)
    z <- vector(mode = "list", length = n_Reps)
    for (j in 1:n_Reps) {
      z[[j]] <- c(rep(u[j]:v[j], times = iBlocks))
    }
    z <- unlist(z)
    if (stacked == "vertical") {
      #######################################################################

      x$bookROWCol <- NewBook |>
        dplyr::mutate(
          ROW = z,
          COLUMN = rep(rep(1:iBlocks, each = sizeIblocks), n_Reps)
        )
      df0 <- x$bookROWCol
      df0 <- df0[order(df0$ROW, decreasing = FALSE), ]
      nCols <- max(df0$COLUMN)
      newPlots <- planter_transform(
        plots = plots,
        planter = planter,
        reps = n_Reps,
        cols = nCols,
        units = NULL
      )
      df0$PLOT <- newPlots
      books0[[1]] <- df0

      #######################################################################

      if (sizeIblocks %% 2 != 0 & sqrt(sizeIblocks) %% 1 != 0) {
        z_rows <- rep(1:(iBlocks * n_Reps), each = sizeIblocks)

        x$bookROWCol <- NewBook |>
          dplyr::mutate(
            ROW = z_rows,
            COLUMN = rep(rep(1:sizeIblocks, times = iBlocks), n_Reps)
          )
        df01 <- x$bookROWCol
        df01 <- df01[order(df01$ROW, decreasing = FALSE), ]
        nCols <- max(df01$COLUMN)
        newPlots <- planter_transform(
          plots = plots,
          planter = planter,
          reps = n_Reps,
          cols = nCols,
          units = NULL
        )
        df01$PLOT <- newPlots
        books01[[1]] <- df01
      }

      #######################################################################

      if (sizeIblocks %% 2 == 0) {
        z_rows <- rep(1:(iBlocks * n_Reps), each = sizeIblocks)

        x$bookROWCol <- NewBook |>
          dplyr::mutate(
            ROW = z_rows,
            COLUMN = rep(rep(1:sizeIblocks, times = iBlocks), n_Reps)
          )
        df02 <- x$bookROWCol
        df02 <- df02[order(df02$ROW, decreasing = FALSE), ]
        nCols <- max(df02$COLUMN)
        newPlots <- planter_transform(
          plots = plots,
          planter = planter,
          reps = n_Reps,
          cols = nCols,
          units = NULL
        )
        df02$PLOT <- newPlots
        books02[[1]] <- df02
      }

      #######################################################################

      # books1
      if ((sizeIblocks %% 2 == 0 || sqrt(sizeIblocks) %% 1 == 0) &
        iBlocks %% 2 != 0) {
        r <- numbers::primeFactors(iBlocks)
        if (length(r) > 2) r <- c(r[1], prod(r[2:length(r)]))
        if (length(r) == 1) r <- c(1, r)
        y <- numbers::primeFactors(sizeIblocks)
        if (sizeIblocks == 2) y <- c(1, y)
        if (length(y) > 1) {
          if (length(y) == 2) {
            y1 <- y
            y2 <- rev(y)
            Y <- unique(data.frame(rbind(y1, y2)))
            dm <- nrow(Y)
          }
          if (length(y) > 2) {
            y1 <- c(y[1], prod(y[2:length(y)]))
            y2 <- rev(y1)
            y3 <- c(prod(y[1:length(y) - 1]), y[length(y)])
            y4 <- rev(y3)
            Y <- unique(data.frame(rbind(y1, y2, y3, y4)))
            dm <- nrow(Y)
          }
        }
        books1 <- vector(mode = "list", length = dm)
        for (k in 1:dm) {
          s1 <- as.numeric(Y[k, ][1])
          s2 <- as.numeric(Y[k, ][2])
          w_r <- 1:(r[1] * s1 * n_Reps)
          u_r <- seq(1, length(w_r), by = s1)
          v_r <- seq(s1, length(w_r), by = s1)
          z_rows <- vector(mode = "list", length = n_Reps * r[1])
          for (j in 1:(n_Reps * r[1])) {
            z_rows[[j]] <- rep(c(rep(u_r[j]:v_r[j], each = s2)), times = r[2])
          }
          z_rows <- unlist(z_rows)
          # COLUMN:
          w_c <- 1:(r[2] * s2)
          u_c <- seq(1, length(w_c), by = s2)
          v_c <- seq(s2, length(w_c), by = s2)
          z_cols <- vector(mode = "list", length = r[2])
          for (i in 1:r[2]) {
            z_cols[[i]] <- c(rep(u_c[i]:v_c[i], times = s1))
          }
          z_cols <- unlist(z_cols)
          z_cols_new <- rep(z_cols, times = r[1] * n_Reps)
          x$bookROWCol <- NewBook |>
            dplyr::mutate(
              ROW = z_rows,
              COLUMN = z_cols_new
            )
          df <- x$bookROWCol
          df <- df[order(df$ROW, decreasing = FALSE), ]
          nCols <- max(df$COLUMN)
          newPlots <- planter_transform(
            plots = plots,
            planter = planter,
            reps = n_Reps,
            cols = nCols,
            units = NULL
          )
          df$PLOT <- newPlots
          books1[[k]] <- df
        }
      }
      # books2
      if ((sizeIblocks %% 2 == 0 || sqrt(sizeIblocks) %% 1 == 0) &
        iBlocks %% 2 == 0) {
        r <- numbers::primeFactors(iBlocks)
        if (length(r) > 2) r <- c(prod(r[1:length(r) - 1]), r[length(r)])
        if (length(r) == 1) r <- c(1, r)
        y <- numbers::primeFactors(sizeIblocks)
        if (sizeIblocks == 2) y <- c(1, y)
        if (length(y) > 1) {
          if (length(y) == 2) {
            y1 <- y
            y2 <- rev(y)
            Y <- unique(data.frame(rbind(y1, y2)))
            dm <- nrow(Y)
          }
          if (length(y) > 2) {
            y1 <- c(y[1], prod(y[2:length(y)]))
            y2 <- rev(y1)
            y3 <- c(prod(y[1:length(y) - 1]), y[length(y)])
            y4 <- rev(y3)
            Y <- unique(data.frame(rbind(y1, y2, y3, y4)))
            dm <- nrow(Y)
          }
        }
        books2 <- vector(mode = "list", length = dm)
        for (k in 1:dm) {
          s1 <- as.numeric(Y[k, ][1])
          s2 <- as.numeric(Y[k, ][2])
          w_r <- 1:(r[1] * s1 * n_Reps)
          u_r <- seq(1, length(w_r), by = s1) # y[1]
          v_r <- seq(s1, length(w_r), by = s1) # y[1]
          z_rows <- vector(mode = "list", length = n_Reps * r[1])
          for (j in 1:(n_Reps * r[1])) {
            z_rows[[j]] <- rep(c(rep(u_r[j]:v_r[j], each = s2)), times = r[2]) # y[2]
          }
          z_rows <- unlist(z_rows)
          # COLUMN:
          w_c <- 1:(r[2] * s2) # y[2]
          u_c <- seq(1, length(w_c), by = s2) # y[2]
          v_c <- seq(s2, length(w_c), by = s2) # y[2]
          z_cols <- vector(mode = "list", length = r[2])
          for (i in 1:r[2]) {
            z_cols[[i]] <- c(rep(u_c[i]:v_c[i], times = s1)) # y[1]
          }
          z_cols <- unlist(z_cols)
          z_cols_new <- rep(z_cols, times = r[1] * n_Reps)
          x$bookROWCol <- NewBook |>
            dplyr::mutate(
              ROW = z_rows,
              COLUMN = z_cols_new
            )
          df <- x$bookROWCol
          df <- df[order(df$ROW, decreasing = FALSE), ]
          nCols <- max(df$COLUMN)
          newPlots <- planter_transform(
            plots = plots,
            planter = planter,
            reps = n_Reps,
            cols = nCols,
            units = NULL
          )
          df$PLOT <- newPlots
          books2[[k]] <- df
        }
      }
      # books3
      if (iBlocks %% 2 == 0) {
        r <- numbers::primeFactors(iBlocks)
        if (iBlocks == 2) r <- c(1, r)
        r <- rev(r)
        if (length(r) > 1) {
          if (length(r) == 2) {
            r1 <- r
            r2 <- rev(r)
            R <- unique(data.frame(rbind(r1, r2)))
            dm <- nrow(R)
          }
          if (length(r) > 2) {
            r1 <- c(r[1], prod(r[2:length(r)]))
            r2 <- rev(r1)
            r3 <- c(prod(r[1:length(r) - 1]), r[length(r)])
            r4 <- rev(r3)
            R <- unique(data.frame(rbind(r1, r2, r3, r4)))
            dm <- nrow(R)
          }
        }
        books3 <- vector(mode = "list", length = dm)
        y <- numbers::primeFactors(sizeIblocks)
        if (sizeIblocks == 2) y <- c(1, y)
        for (k in 1:dm) {
          w1 <- as.numeric(R[k, ][1])
          w2 <- as.numeric(R[k, ][2])
          if (length(y) == 1) y <- c(2, y)
          if (length(y) > 2) y <- c(y[1], prod(y[2:length(y)]))
          w_r <- 1:(w1 * n_Reps) # r[1]
          u_r <- seq(1, length(w_r), by = w1) # r[1]
          v_r <- seq(w1, length(w_r), by = w1) # r[1]
          z_rows <- vector(mode = "list", length = n_Reps)
          for (j in 1:(n_Reps)) {
            z_rows[[j]] <- c(rep(u_r[j]:v_r[j], each = w2 * sizeIblocks)) # r[2]
          }
          z_rows <- unlist(z_rows)
          # COLUMN:
          w_c <- 1:(w2 * sizeIblocks) # r[2]
          z_cols <- vector(mode = "list", length = n_Reps)
          for (i in 1:n_Reps) {
            z_cols[[i]] <- rep(w_c, times = w1) # r[1]
          }
          z_cols <- as.vector(unlist(z_cols))
          z_cols_new <- z_cols
          x$bookROWCol <- NewBook |>
            dplyr::mutate(
              ROW = z_rows,
              COLUMN = z_cols_new
            )
          df <- x$bookROWCol
          df <- df[order(df$ROW, decreasing = FALSE), ]
          nCols <- max(df$COLUMN)
          newPlots <- planter_transform(
            plots = plots,
            planter = planter,
            reps = n_Reps,
            cols = nCols,
            units = NULL
          )
          df$PLOT <- newPlots
          books3[[k]] <- df
        }
      }
      ########################################################################
    } else if (stacked == "horizontal") {
      x$bookROWCol <- NewBook |>
        dplyr::mutate(
          ROW = rep(rep(1:iBlocks, each = sizeIblocks), n_Reps),
          COLUMN = z
        )
      df2 <- x$bookROWCol
      nRows <- max(df2$ROW)
      nCols <- max(df2$COLUMN)
      newPlots <- planter_transform(
        plots = plots, planter = planter,
        reps = n_Reps, cols = nCols,
        mode = "Horizontal",
        units = NULL
      )
      df2$PLOT <- newPlots
      books4[[1]] <- df2


      books21 <- list(NULL)
      x$bookROWCol <- NewBook |>
        dplyr::mutate(
          ROW = rep(rep(1:sizeIblocks, times = iBlocks), n_Reps),
          COLUMN = rep(1:(iBlocks * n_Reps), each = sizeIblocks)
        )


      df21 <- x$bookROWCol
      nRows <- max(df21$ROW)
      nCols <- max(df21$COLUMN)
      newPlots <- planter_transform(
        plots = plots, planter = planter,
        reps = n_Reps, cols = nCols,
        mode = "Horizontal",
        units = NULL
      )
      df21$PLOT <- newPlots
      books21[[1]] <- df21

      if (sizeIblocks %% 2 == 0 || sqrt(sizeIblocks) %% 1 == 0) {
        Y <- factor_subsets(sizeIblocks, all_factors = TRUE)$comb_factors
        Y <- as.data.frame(Y)
        dm <- nrow(Y)
        books5 <- vector(mode = "list", length = dm)
        for (h in 1:dm) {
          s1 <- as.numeric(Y[h, ][1])
          s2 <- as.numeric(Y[h, ][2])
          w_r <- 1:(iBlocks * s1)
          u_r <- seq(1, length(w_r), by = s1)
          v_r <- seq(s1, length(w_r), by = s1)
          z_rows <- vector(mode = "list", length = iBlocks * s1)
          for (j in 1:iBlocks) {
            z_rows[[j]] <- rep(u_r[j]:v_r[j], each = s2)
          }
          z_rows <- unlist(z_rows)
          length(z_rows)
          ROWS <- rep(z_rows, times = n_Reps)
          # COLUMN:
          w_c <- 1:(s2 * n_Reps)
          u_c <- seq(1, length(w_c), by = s2)
          v_c <- seq(s2, length(w_c), by = s2)
          z_cols <- vector(mode = "list", length = n_Reps)
          for (i in 1:n_Reps) {
            z_cols[[i]] <- c(rep(u_c[i]:v_c[i], times = s1 * iBlocks))
          }
          COLUMNS <- unlist(z_cols)
          x$bookROWCol <- NewBook |>
            dplyr::mutate(
              ROW = ROWS,
              COLUMN = COLUMNS
            )

          df5 <- x$bookROWCol
          nRows <- max(df5$ROW)
          nCols <- max(df5$COLUMN)
          newPlots <- planter_transform(
            plots = plots, planter = planter,
            reps = n_Reps, cols = nCols,
            mode = "Horizontal",
            units = NULL
          )
          df5$PLOT <- newPlots
          books5[[h]] <- df5
        }
        ####################################################################
      }
    } else if (stacked == "grid_panel") {
      if (n_Reps > 2) {
        if (n_Reps %% 2 == 0 || sqrt(n_Reps) %% 1 == 0) {
          t <- numbers::primeFactors(n_Reps)
          nROWs <- t[1] * sizeIblocks
          s <- t[1]
          nCols <- t[length(t)] * iBlocks
          if (length(t) > 2) {
            s <- t[1] * t[2]
            nROWs <- s * sizeIblocks
          }
          n0 <- t[length(t)]
          w0 <- 1:(nROWs)
          u0 <- seq(1, length(w0), by = sizeIblocks)
          v0 <- seq(sizeIblocks, length(w0), by = sizeIblocks)
          z0 <- vector(mode = "list", length = s)
          for (j in 1:(s)) {
            z0[[j]] <- rep(c(rep(u0[j]:v0[j], times = iBlocks)), n0)
          }
          z0 <- unlist(z0)
          x$bookROWCol <- NewBook |>
            dplyr::mutate(
              ROW = z0,
              COLUMN = rep(rep(1:nCols, each = sizeIblocks), s)
            )
          df6 <- x$bookROWCol
          df6 <- df6[order(df6$REP, df6$UNIT), ]
          nRows <- max(df6$ROW)
          nCols <- max(df6$COLUMN)
          number_units <- length(levels(as.factor(df6$IBLOCK)))
          newPlots <- planter_transform(
            plots = plots,
            planter = planter,
            reps = n_Reps,
            cols = nCols,
            mode = "Grid",
            units = number_units
          )
          df6$PLOT <- newPlots
          books6[[1]] <- df6

          nROWs <- t[2] * sizeIblocks
          s <- t[2]
          nCols <- t[1] * iBlocks
          if (length(t) > 2) {
            s <- t[2] * t[3]
            nROWs <- s * sizeIblocks
          }
          n0 <- t[1]
          w0 <- 1:(nROWs)
          u0 <- seq(1, length(w0), by = sizeIblocks)
          v0 <- seq(sizeIblocks, length(w0), by = sizeIblocks)
          z0 <- vector(mode = "list", length = s)
          for (j in 1:(s)) {
            z0[[j]] <- rep(c(rep(u0[j]:v0[j], times = iBlocks)), n0)
          }
          z0 <- unlist(z0)
          x$bookROWCol <- NewBook |>
            dplyr::mutate(
              ROW = z0,
              COLUMN = rep(rep(1:nCols, each = sizeIblocks), s)
            )
          df7 <- x$bookROWCol
          df7 <- df7[order(df7$REP, df7$UNIT), ]
          nRows <- max(df7$ROW)
          nCols <- max(df7$COLUMN)
          number_units <- length(levels(as.factor(df7$IBLOCK)))
          newPlots <- planter_transform(
            plots = plots,
            planter = planter,
            reps = n_Reps,
            cols = nCols,
            mode = "Grid",
            units = number_units
          )
          df7$PLOT <- newPlots
          if (sqrt(n_Reps) %% 1 == 0) {
            books7[[1]] <- NULL
          } else {
            books7[[1]] <- df7
          }
        }
      }
    }
    books <- c(
      books1, books2, books0, books3, books4, books5,
      books6, books7, books21, books01, books02
    )
    newBooks <- books[!sapply(books, is.null)]
    newBooksLocs[[countLocs]] <- unique(newBooks)
    countLocs <- countLocs + 1
  }
  opt <- layout
  newBooksSelected <- newBooksLocs[[site]]
  opt_available <- 1:length(newBooksSelected)
  if (all(opt_available != opt)) {
    message(cat(
      " Option for layout is not available!", "\n", "\n",
      "*********************************************", "\n",
      "*********************************************", "\n", "\n",
      "Layout options available for this design are:", "\n", "\n",
      opt_available, "\n", "\n",
      "*********************************************", "\n",
      "*********************************************"
    ))
    return(NULL)
  }
  df1 <- newBooksSelected[opt]
  df <- as.data.frame(df1)
  if (x$infoDesign$id_design %in% c(10, 11, 12, 8)) {
    allSites <- vector(mode = "list", length = nlocs)
    for (st in 1:nlocs) {
      newBooksSelected_1 <- newBooksLocs[[st]]
      df_1 <- newBooksSelected_1[opt]
      allSites[[st]] <- as.data.frame(df_1)
    }
    allSitesFieldbook <- dplyr::bind_rows(allSites)
    allSitesFieldbook <- allSitesFieldbook[, c(1:3, 9, 10, 4:8)]
    df <- df[, c(1:3, 9, 10, 4:8)]
    df$ENTRY <- as.factor(df$ENTRY)
    rows <- max(as.numeric(df$ROW))
    cols <- max(as.numeric(df$COLUMN))
    ds <- "Square Lattice Design Field Layout "
    if (x$infoDesign$id_design == 8) ds <- "Incomplete Blocks Design Field Layout "
    if (x$infoDesign$id_design == 11) ds <- "Rectangular Lattice Design Field Layout "
    if (x$infoDesign$id_design == 12) ds <- "Alpha Lattice Design Field Layout "

    main <- paste0(ds, rows, "X", cols)
    p1 <- desplot::desplot(
      ENTRY ~ COLUMN + ROW,
      flip = FALSE,
      out1 = REP,
      out2 = IBLOCK,
      out2.gpar = list(col = "black", lty = 3),
      text = ENTRY,
      cex = 1,
      shorten = "no",
      data = df,
      xlab = "COLUMNS",
      ylab = "ROWS",
      main = main,
      show.key = FALSE,
      gg = TRUE
    )
    
    p1 <- add_gg_features(p1)
    
    df$REP <- as.factor(df$REP)

    p2 <- desplot::desplot(
      REP ~ COLUMN + ROW,
      flip = FALSE,
      out1 = REP,
      text = PLOT, cex = 1, shorten = "no",
      data = df, xlab = "COLUMNS", ylab = "ROWS",
      main = main,
      show.key = FALSE,
      gg = TRUE
    )
    
    p2 <- add_gg_features(p2)
  }
  return(
    list(
      p1 = p1,
      p2 = p2,
      df = df,
      newBooks = newBooksSelected,
      allSitesFieldbook = allSitesFieldbook
    )
  )
}

add_gg_features <- function(ggplot2_obj) {
  p1 <- ggplot2_obj
  # Explicitly remove all legends
  p1 <- p1 + ggplot2::guides(
    fill = "none",   # Remove legend for fill
    color = "none",  # Remove legend for color (if used)
    text = "none"    # Remove legend for text labels
  )
  
  # Format the x and y axes to show integer labels
  p1 <- p1 +
    ggplot2::scale_x_continuous(breaks = function(x) seq(floor(min(x)), ceiling(max(x)), by = 1)) +
    ggplot2::scale_y_continuous(breaks = function(x) seq(floor(min(x)), ceiling(max(x)), by = 1))
  
  # Apply a minimal theme for better aesthetics
  p1 <- p1 + ggplot2::theme_minimal() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", size = 12),
      axis.title = ggplot2::element_text(size = 11),
      axis.text = ggplot2::element_text(size = 10)
    )
  
  return(p1)
}
